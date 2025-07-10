import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repo/firebase_repository.dart';
import '../widgets/components/my_appbar.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _coinController = TextEditingController();
  final _amountController = TextEditingController();
  String _type = 'buy';
  Future<void> _saveTransaction() async {
    await TransactionRepository.saveTransaction(
      coin: _coinController.text.trim(),
      amountText: _amountController.text.trim(),
      type: _type,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ' Add transactions', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _type,
                  onChanged: (value) {
                    setState(() {
                      _type = value!;
                    });
                  },
                  items: ['buy', 'sell'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                const SizedBox(height: 20), // Space before button

                TextFormField(
                  controller: _coinController,
                  decoration:
                      const InputDecoration(labelText: 'Coin (e.g., BTC)'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20), // Space before button

                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 20), // Space before button

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveTransaction,
                  child: const Text('Save Transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: StreamBuilder<QuerySnapshot>(
        stream: TransactionRepository().getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No transactions found'));
          }

          final transactions = snapshot.data!.docs;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final String coin = transaction['coin'];
              final double amount = transaction['amount'];
              final String type = transaction['type'];

              bool isBuy = type == 'buy';
              Color statusColor = isBuy ? Colors.green : Colors.red;
              IconData icon = isBuy ? Icons.arrow_upward : Icons.arrow_downward;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: statusColor.withOpacity(0.2),
                    child: Icon(icon, color: statusColor),
                  ),
                  title: Text(
                    '$coin Transaction',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    '${isBuy ? "Bought" : "Sold"} $amount $coin',
                    style: TextStyle(color: statusColor),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
