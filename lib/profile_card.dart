import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String hobi;
  final int skorAktivitas; 

  const ProfileCard({
    Key? key,
    required this.nama,
    required this.nim,
    required this.hobi,
    required this.skorAktivitas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ekstraksi digit dari NIM lu (20240801020)
    int lastDigit = int.parse(nim.substring(nim.length - 1)); // Hasil: 0
    int secondLastDigit = int.parse(nim.substring(nim.length - 2, nim.length - 1)); // Hasil: 2
    int lastTwoDigits = int.parse(nim.substring(nim.length - 2)); // Hasil: 20

    // Kalkulasi Formula Sesuai Ketentuan Soal
    double cardWidth = 320.0 + (secondLastDigit * 5); // 320 + 10 = 330.0
    double cardRadius = 12.0 + (lastDigit * 1.5); // 12 + 0 = 12.0
    double logoSize = 60.0 + (lastDigit * 2); // 60 + 0 = 60.0
    double separatorWidth = 15.0 + lastDigit; // 15 + 0 = 15.0
    int finalSkorAktivitas = lastTwoDigits + 50; // 20 + 50 = 70

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, 
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(cardRadius),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                ),
                padding: const EdgeInsets.all(8.0),
                child: FlutterLogo(size: logoSize),
              ),
              SizedBox(width: separatorWidth),
              Expanded( 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kartu Praktikan",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(thickness: 1.5), 
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow("NIM", nim),
              const SizedBox(height: 8),
              _buildDetailRow("Hobi", hobi),
              const SizedBox(height: 8),
              _buildDetailRow("Skor Aktivitas", finalSkorAktivitas.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 120, child: Text(label, style: const TextStyle(color: Colors.grey))),
        const Text(" : ", style: TextStyle(fontWeight: FontWeight.w600)),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
      ],
    );
  }
}