using { Currency, managed, sap } from '@sap/cds/common';
namespace com.nadsportfolio.inventory;

entity Products : managed {
  key ID : Integer;
  @mandatory name  : localized String(111);
  descr  : localized String(1111);
  @mandatory supplier : Association to Suppliers;
  category : Association to Categories;
  stock  : Integer;
  price  : Decimal;
  currency : Currency;
  image : LargeBinary @Core.MediaType : 'image/png';
}

entity Suppliers : managed {
  key ID : Integer;
  @mandatory name   : String(111);
  Email: String(111);
  phoneNumber: String(25);
  address : String(255);
  
  products  : Association to many Products on products.supplier = $self;
}

/** Hierarchically organized Code List for Categories */
entity Categories : sap.common.CodeList {
  key ID   : Integer;
  parent   : Association to Categories;
  children : Composition of many Categories on children.parent = $self;
}
