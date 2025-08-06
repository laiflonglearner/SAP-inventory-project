```cds
using { Currency, managed } from '@sap/cds/common';
namespace com.nadsportfolio.inventory;

entity Products : managed {
  key ID              : Integer;
  @mandatory name     : localized String(100);
  description         : localized String(1000);
  @mandatory supplier : Association to Suppliers;
  stock               : Association to many Stock on stock.product = $self;
  price               : Decimal(10,2);
  currency            : Currency;
}

entity Suppliers : managed {
  key ID               : Integer;
  @mandatory name      : String(100);
  email                : String(100);
  phone                : String(25);
  address              : String(255);
  products             : Association to many Products on products.supplier = $self;
}

entity Stock : managed {
  key ID              : Integer;
  @mandatory product  : Association to Products;
  quantity            : Integer @assert.range: [0, 999999];
  lastUpdated         : Timestamp @cds.on.update: $now;
}

```

# Inventory Management Data Model

This document describes the Core Data Services (CDS) data model for an inventory management system, defined using SAP's CDS framework. The model includes three entities: Products, Suppliers, and Stock, which represent the core components of the inventory system.

## Data Model

The following CDS code defines the structure of the entities and their relationships

### Product Entity

```cds
  using { Currency, managed } from '@sap/cds/common';
```

- Import predefined types from SAP's CDS library for common data types and features
- `Currency` is a special type that ensures fields (like price) are stored with a currency code (e.g., USD, EUR) to handle money correctly.
- The `managed` keyword is a shortcut that automatically adds fields like `createdAt`, `createdBy`, `modifiedAt`, and `modifiedBy` to track who created or updated the data and when. This is useful for auditing and tracking changes in a database.

```cds
namespace com.nadsportfolio.inventory;
```

- Define a namespace to organize our entities, like a folder for this inventory project
- Prevents naming conflicts with other projects (e.g., com.otherproject.Products)

```cds
entity Products : managed {
```

- Defines the Products entity, representing items in the inventory (e.g., laptops, chairs).
- Inherits 'managed' to automatically track who created/updated the record and when.

```cds
 key ID : Integer;
```

- The `key` here means primary key: a unique integer ID for each product (e.g., 1, 2, 3), so every product can be uniquely identified

```cds
@mandatory name : localized String(100);
```

- Product name, required field, supports multiple languages (e.g., "Apple" in English, "Manzana" in Spanish)
- The `@mandatory` means this field must have a value (it can’t be empty) to ensure every product has a name.
- The `localized` keyword is used to support multilangual apps, means the name can be stored in multiple languages (e.g., “Apple” in English, “Manzana” in Spanish).
- Limited to 100 characters to keep data concise

```cds
description : localized String(1000);
```

- Optional description of the product, up to 1000 characters, supports multiple languages
- Useful for detailed info (e.g., "Lightweight laptop with 16GB RAM")

```cds
@mandatory supplier : Association to Suppliers;
```

- Defines a field called `supplier` that links to a single `Suppliers` entity.
- The `Association` keyword means this is a relationship (like a foreign key in a database).
- The `@mandatory` means every product must be linked to a supplier.
- This connects a product to its supplier (e.g., “This laptop is supplied by TechCorp”). It ensures you can track who provides each product.
- **Best practice**: Use associations to model relationships between entities, and make them mandatory if the relationship is critical.

```cds
stock : Association to many Stock on stock.product = $self;
```

- Defines a field called `stock` that links to multiple `Stock` entries.
- The `Association to many` means one product can have many stock records (e.g., stock in different warehouses).
- The `on stock.product = $self` part specifies that the product field in the Stock entity must match this product’s ID.
- **Best practice**: Use to many for one-to-many relationships and clearly define the linking condition to avoid confusion.

```cds
price : Decimal(10,2);
```

- Price of the product, stored as a decimal with 10 digits total, 2 after the decimal (e.g., $ 12345678.90)

---

### Supplier Entity

```cds
entity Suppliers : managed {
  key ID               : Integer;
  @mandatory name      : String(100);
  email                : String(100);
  phone                : String(25);
  address              : String(255);
  ...
}
```

These lines are self-explanatory enough, refer to previous explanations for details on `managed`, `key`, and `@mandatory`.

```cds
products : Association to many Products on products.supplier = $self;
}
```

- Links a supplier to multiple products they supply. The `on products.supplier = $self` means the supplier field in Products must match this supplier’s ID.
- Why? This creates a two-way relationship: products link to their supplier, and suppliers link to their products. This is called a bidirectional relationship.
- **Best practice**: Define both sides of a relationship (in Products and Suppliers) for flexibility in querying data.

---

### Stock Entity

```cds
entity Stock : managed {
  key ID              : Integer;
  ...
}
```

These lines are self-explanatory enough, refer to previous explanations for details.

```cds
@mandatory product : Association to Products;
```

- Links each stock entry to a single product. This is the reverse of the `stock` field in `Products`, forming a one-to-many relationship (one product, many stock entries).
- Why? This ensures each stock record is tied to a specific product (e.g., “50 units of Laptop #1”).

```cds
quantity : Integer @assert.range: [0, 999999];
```

- Stores the number of items in stock as an integer. The `@assert.range: [0, 999999]` ensures the value is between 0 and 999,999. The `@assert.range` annotation enforces data validation at database level.
- Why? Tracks how many items are available. The range prevents negative stock or unrealistically large numbers.

```cds
lastUpdated : Timestamp @cds.on.update: $now;
```

- Stores the date and time when the stock record was last updated, using the Timestamp type (e.g., “2025-08-06T13:17:00Z”). The `@cds.on.update: $now` means this field automatically updates to the current time whenever the record is modified.
- Why? Useful for tracking when stock levels changed without manual updates.
