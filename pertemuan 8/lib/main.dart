import 'package:flutter/material.dart';

import 'models/admin.dart';
import 'models/user.dart';
import 'services/admin_service.dart';
import 'services/user_service.dart';

const int userIdFromNim = 1501;
const int adminIdFromNim = 794;

void main() => runApp(const CrudApiApp());

class CrudApiApp extends StatelessWidget {
  const CrudApiApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User & Admin API CRUD',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff3157d5)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userService = UserService();
  final _adminService = AdminService();
  late Future<List<User>> _usersFuture;
  late Future<List<Admin>> _adminsFuture;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _usersFuture = _userService.getUsers();
    _adminsFuture = _adminService.getAdmins();
  }

  void _refresh() => setState(_reload);

  Future<void> _showUserDetail(int id) async {
    await showDialog<void>(
      context: context,
      builder: (_) => FutureBuilder<User>(
        future: _userService.getUser(id),
        builder: (context, snapshot) => DetailDialog(
          title: 'Detail User #$id',
          loading: snapshot.connectionState == ConnectionState.waiting,
          error: snapshot.error,
          child:
              snapshot.data == null ? null : UserDetails(user: snapshot.data!),
        ),
      ),
    );
  }

  Future<void> _showAdminDetail(int id) async {
    await showDialog<void>(
      context: context,
      builder: (_) => FutureBuilder<Admin>(
        future: _adminService.getAdmin(id),
        builder: (context, snapshot) => DetailDialog(
          title: 'Detail Admin #$id',
          loading: snapshot.connectionState == ConnectionState.waiting,
          error: snapshot.error,
          child: snapshot.data == null
              ? null
              : AdminDetails(admin: snapshot.data!),
        ),
      ),
    );
  }

  Future<void> _deleteAdmin(Admin admin) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Admin?'),
        content: Text('Hapus data ${admin.name} dengan ID ${admin.id}?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    try {
      await _adminService.deleteAdmin(admin.id);
      if (!mounted) return;
      setState(_reload);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Admin berhasil dihapus (simulasi API).')));
    } catch (error) {
      if (mounted) _showError(error);
    }
  }

  Future<void> _createUser() async {
    final result = await showDialog<User>(
        context: context, builder: (_) => const UserFormDialog());
    if (result == null || !mounted) return;
    try {
      await _userService.createUser(result);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('POST User berhasil dijalankan.')));
        _refresh();
      }
    } catch (error) {
      if (mounted) _showError(error);
    }
  }

  Future<void> _updateUser(User user) async {
    final result = await showDialog<User>(
        context: context, builder: (_) => UserFormDialog(user: user));
    if (result == null || !mounted) return;
    try {
      await _userService.updateUser(user.id,
          name: result.name, email: result.email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PUT User berhasil dijalankan.')));
      }
    } catch (error) {
      if (mounted) _showError(error);
    }
  }

  Future<void> _patchUser(User user) async {
    try {
      await _userService.patchUser(user.id, name: user.name);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PATCH User berhasil dijalankan.')));
      }
    } catch (error) {
      if (mounted) _showError(error);
    }
  }

  Future<void> _deleteUser(User user) async {
    try {
      await _userService.deleteUser(user.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('DELETE User berhasil dijalankan.')));
      }
    } catch (error) {
      if (mounted) _showError(error);
    }
  }

  void _showError(Object error) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text('Gagal: $error')));

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('User & Admin API CRUD'),
            actions: [
              IconButton(
                  onPressed: _refresh,
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh')
            ],
            bottom:
                const TabBar(tabs: [Tab(text: 'Users'), Tab(text: 'Admins')]),
          ),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: _createUser,
              icon: const Icon(Icons.person_add),
              label: const Text('POST User')),
          body: TabBarView(children: [
            UserList(
                future: _usersFuture,
                onDetail: _showUserDetail,
                onUpdate: _updateUser,
                onPatch: _patchUser,
                onDelete: _deleteUser),
            AdminList(
                future: _adminsFuture,
                onDetail: _showAdminDetail,
                onDelete: _deleteAdmin),
          ]),
        ),
      );
}

class UserList extends StatefulWidget {
  final Future<List<User>> future;
  final Future<void> Function(int) onDetail;
  final Future<void> Function(User) onUpdate;
  final Future<void> Function(User) onPatch;
  final Future<void> Function(User) onDelete;
  const UserList(
      {super.key,
      required this.future,
      required this.onDetail,
      required this.onUpdate,
      required this.onPatch,
      required this.onDelete});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList>
    with AutomaticKeepAliveClientMixin<UserList> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateQuery(String value) => setState(() => _query = value);

  bool _matches(User user, String query) =>
      user.id.toString() == query ||
      user.name.toLowerCase().contains(query) ||
      user.email.toLowerCase().contains(query) ||
      user.city.toLowerCase().contains(query);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final query = _query.trim().toLowerCase();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: TextField(
            controller: _searchController,
            onChanged: _updateQuery,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              labelText: 'Cari User',
              hintText: 'Nama, email, kota, atau ID',
              prefixIcon: const Icon(Icons.search),
              border: const OutlineInputBorder(),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Hapus pencarian',
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _updateQuery('');
                      },
                    ),
            ),
          ),
        ),
        Expanded(
            child: AsyncList<User>(
          future: widget.future,
          emptyText: 'Data User kosong',
          filter: query.isEmpty ? null : (user) => _matches(user, query),
          itemBuilder: (context, user) => Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${user.id}')),
              title: Text(user.name),
              subtitle: Text('${user.email}\n${user.city}'),
              isThreeLine: true,
              onTap: () => widget.onDetail(user.id),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'detail') widget.onDetail(user.id);
                  if (value == 'put') widget.onUpdate(user);
                  if (value == 'patch') widget.onPatch(user);
                  if (value == 'delete') widget.onDelete(user);
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'detail', child: Text('Detail (GET)')),
                  PopupMenuItem(value: 'put', child: Text('PUT nama & email')),
                  PopupMenuItem(value: 'patch', child: Text('PATCH nama')),
                  PopupMenuItem(value: 'delete', child: Text('DELETE User')),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}

class AdminList extends StatelessWidget {
  final Future<List<Admin>> future;
  final Future<void> Function(int) onDetail;
  final Future<void> Function(Admin) onDelete;
  const AdminList(
      {super.key,
      required this.future,
      required this.onDetail,
      required this.onDelete});

  @override
  Widget build(BuildContext context) => AsyncList<Admin>(
        future: future,
        emptyText: 'Data Admin kosong',
        itemBuilder: (context, admin) => Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${admin.id}')),
            title: Text(admin.name),
            subtitle: Text('${admin.email}\n${admin.department}'),
            isThreeLine: true,
            onTap: () => onDetail(admin.id),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'detail') onDetail(admin.id);
                if (value == 'delete') onDelete(admin);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'detail', child: Text('Detail (GET)')),
                PopupMenuItem(value: 'delete', child: Text('DELETE Admin')),
              ],
            ),
          ),
        ),
      );
}

class AsyncList<T> extends StatelessWidget {
  final Future<List<T>> future;
  final String emptyText;
  final Widget Function(BuildContext, T) itemBuilder;
  final bool Function(T)? filter;
  const AsyncList(
      {super.key,
      required this.future,
      required this.emptyText,
      required this.itemBuilder,
      this.filter});

  @override
  Widget build(BuildContext context) => FutureBuilder<List<T>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text('Gagal mengambil data:\n${snapshot.error}',
                        textAlign: TextAlign.center)));
          }
          final data = snapshot.data ?? <T>[];
          if (data.isEmpty) return Center(child: Text(emptyText));
          final matches = filter == null ? data : data.where(filter!).toList();
          if (matches.isEmpty) {
            return const Center(child: Text('User tidak ditemukan'));
          }
          return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: matches.length,
              itemBuilder: (context, index) =>
                  itemBuilder(context, matches[index]));
        },
      );
}

class DetailDialog extends StatelessWidget {
  final String title;
  final bool loading;
  final Object? error;
  final Widget? child;
  const DetailDialog(
      {super.key,
      required this.title,
      required this.loading,
      required this.error,
      required this.child});

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(title),
        content: loading
            ? const SizedBox(
                height: 80, child: Center(child: CircularProgressIndicator()))
            : error != null
                ? Text('Gagal: $error')
                : child,
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'))
        ],
      );
}

class UserDetails extends StatelessWidget {
  final User user;
  const UserDetails({super.key, required this.user});
  @override
  Widget build(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${user.id}'),
            Text('Nama: ${user.name}'),
            Text('Email: ${user.email}'),
            Text('Kota: ${user.city}')
          ]);
}

class AdminDetails extends StatelessWidget {
  final Admin admin;
  const AdminDetails({super.key, required this.admin});
  @override
  Widget build(BuildContext context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${admin.id}'),
            Text('Nama: ${admin.name}'),
            Text('Email: ${admin.email}'),
            Text('Department: ${admin.department}')
          ]);
}

class UserFormDialog extends StatefulWidget {
  final User? user;
  const UserFormDialog({super.key, this.user});
  @override
  State<UserFormDialog> createState() => _UserFormDialogState();
}

class _UserFormDialogState extends State<UserFormDialog> {
  late final TextEditingController _name;
  late final TextEditingController _email;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.user?.name);
    _email = TextEditingController(text: widget.user?.email);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(widget.user == null ? 'POST User Baru' : 'PUT User'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Nama')),
          TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'))
        ]),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal')),
          FilledButton(
            onPressed: () {
              if (_name.text.trim().isEmpty || _email.text.trim().isEmpty) {
                return;
              }
              Navigator.pop(
                  context,
                  User(
                      id: widget.user?.id ?? userIdFromNim,
                      name: _name.text.trim(),
                      email: _email.text.trim(),
                      city: widget.user?.city ?? 'Jakarta'));
            },
            child: const Text('Simpan'),
          ),
        ],
      );
}
