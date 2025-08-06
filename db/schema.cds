using { Currency, managed } from '@sap/cds/common';
namespace com.nadsportfolio.inventory;

entity Products : managed {
  key ID              : Integer;
  @mandatory name     : localized String(100);
  description         : localized String(1000);
  @mandatory supplier : Association to Suppliers; //many to one with Suppliers entity
  stock               : Association to one Stock on stock.product = $self; //one to one with Stock entity
  price               : Decimal(10,2);
  currency            : Currency;
}

entity Suppliers : managed {
  key ID               : Integer;
  @mandatory name      : String(100);
  email                : String(100);
  phone                : String(25);
  address              : String(255);
  products             : Association to many Products on products.supplier = $self; //one to many with Products entity
}

entity Stock : managed {
    key product         : Association to Products; //one to one with Products entity
    quantity            : Integer @assert.range: [0, 999999];
    lastUpdated         : Timestamp @cds.on.update: $now;
}