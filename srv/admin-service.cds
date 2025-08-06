using { com.nadsportfolio.inventory as db } from '../db/schema';

@path: '/admin'
@requires: 'admin'
service AdminService {
  entity Products @(
    odata.draft.enabled,
    title: 'Products',
    description: 'Manage product inventory'
  ) as projection on db.Products;

  entity Suppliers @(
    title: 'Suppliers',
    description: 'Manage supplier details'
  ) as projection on db.Suppliers;

  entity Stock @(
    title: 'Stock',
    description: 'Manage stock levels'
  ) as projection on db.Stock;

  action restock(productID: Integer, quantity: Integer) returns { success: Boolean; message: String };
}