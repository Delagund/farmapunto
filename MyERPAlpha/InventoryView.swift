 List {
                ForEach(inventories) { inventory in
                    NavigationLink(value: inventory) {
                        VStack(alignment: .leading) {
                            Text(inventory.product.productName)
                                .font(.title3)
                                .fontWeight(.semibold)
                            HStack{
                                Text("Qty")
                                Text("\(inventory.qtyInStock)")
                            }
                            .font(.system(size: 15, design: .rounded))
                            .fontWeight(.light)
                        }
                    }
                }
                .onDelete(perform: deleteItems)