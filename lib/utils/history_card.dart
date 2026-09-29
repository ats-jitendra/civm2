import 'package:CIVM/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget historyCard(LogModel log, int index){
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: 44,
        //   height: 44,
        //   decoration: BoxDecoration(
        //     color: const Color(0xff073B78).withOpacity(.1),
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: const Icon(Icons.history, color: Color(0xff073B78)),
        // ),
        Container(
  width: 44,
  height: 44,
  decoration: BoxDecoration(
    color: const Color(0xff073B78).withOpacity(.1),
    borderRadius: BorderRadius.circular(12),
  ),
  child: Center(
    child: Text(
      "${index + 1}",
      style: const TextStyle(
        color: Color(0xff073B78),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  ),
),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Action + Token No
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Action",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            log.action,
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Token No",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff073B78).withOpacity(.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          log.tokenNo.toString(), // 5
                          style: const TextStyle(
                            color: Color(0xff073B78),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(height: 1, color: Colors.grey.shade200),

              const SizedBox(height: 16),

              /// Description
              Text(
                "Description",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                log.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 14),
              Text(
                "Performed At",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                DateFormat(
                  'MM/dd/yyyy hh:mm a',
                ).format(DateTime.parse(log.performedAt)),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),

              /// Performed By
              Text(
                "Performed By",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: const Color(0xff073B78),
                    child: Text(
                      log.performedByName.isNotEmpty
                          ? log.performedByName[0].toUpperCase()
                          : "U",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      log.performedByName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
