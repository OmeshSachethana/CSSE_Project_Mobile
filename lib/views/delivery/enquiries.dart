import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class enquiriesFrom extends StatefulWidget {
  const enquiriesFrom({super.key});

  @override
  State<enquiriesFrom> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<enquiriesFrom> {
  // text field controller
  final TextEditingController _orderidController = TextEditingController();
  final TextEditingController _itemnameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('enquiries');

  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Enquiry Form",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _orderidController,
                  decoration: const InputDecoration(
                      labelText: 'orderid', hintText: 'SI0023'),
                ),
                TextField(
                  controller: _itemnameController,
                  decoration: const InputDecoration(
                      labelText: 'itemname', hintText: 'Cement'),
                ),
                TextField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                      labelText: 'reason', hintText: 'eg. comment'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration:
                      const InputDecoration(labelText: 'S.N', hintText: 'eg.1'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String orderid = _orderidController.text;
                      final String itemname = _itemnameController.text;
                      final String reason = _reasonController.text;
                      final int? sn = int.tryParse(_snController.text);

                      if (sn != null) {
                        await _items.add({
                          "orderid": orderid,
                          "itemname": itemname,
                          "reason": reason,
                          "sn": sn
                        });
                        _orderidController.text = '';
                        _itemnameController.text = '';
                        _reasonController.text = '';
                        _snController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Create"))
              ],
            ),
          );
        });
  }

  // for Update operation
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _orderidController.text = documentSnapshot['orderid'];
      _itemnameController.text = documentSnapshot['itemname'];
      _reasonController.text = documentSnapshot['reason'];
      _snController.text = documentSnapshot['sn'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _orderidController,
                  decoration: const InputDecoration(
                      labelText: 'Order ID', hintText: 'eg.SI0001'),
                ),
                TextField(
                  controller: _itemnameController,
                  decoration: const InputDecoration(
                      labelText: 'Itemname', hintText: 'eg.Cement'),
                ),
                TextField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                      labelText: 'Reason', hintText: 'eg.Comment'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration:
                      const InputDecoration(labelText: 'S.N', hintText: 'eg.1'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String orderid = _orderidController.text;
                      final String itemname = _itemnameController.text;
                      final String reason = _reasonController.text;
                      final int? sn = int.tryParse(_snController.text);
                      if (sn != null) {
                        await _items.doc(documentSnapshot!.id).update({
                          "orderid": orderid,
                          "itemname": itemname,
                          "reason": reason,
                          "sn": sn
                        });
                        _orderidController.text = '';
                        _itemnameController.text = '';
                        _reasonController.text = '';
                        _snController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }

  // for delete operation
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You have successfully deleted your enquiry")));
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 6, 39, 52),
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('Enquiries'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],
      ),
      body: StreamBuilder(
        stream: _items.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                .where((doc) => doc['orderid'].toLowerCase().contains(
                      searchText.toLowerCase(),
                    ))
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];
                  return Card(
                    color: Color.fromARGB(255, 194, 207, 222),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: const Color.fromARGB(255, 6, 39, 52),
                        child: Text(
                          documentSnapshot['sn'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      title: Text(
                        documentSnapshot['orderid'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(documentSnapshot['itemname'].toString()),
                          // Add your additional text below the existing subtitle
                          Text(documentSnapshot['reason'].toString()),
                        ],
                      ),
                      //subtitle: Text(documentSnapshot['reason'].toString()),
                      //subtitle: Text(documentSnapshot['reason'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _update(documentSnapshot),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                color: Colors.black,
                                onPressed: () => _delete(documentSnapshot.id),
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Create new project button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 6, 39, 52),
        child: const Icon(Icons.add),
      ),
    );
  }
}
