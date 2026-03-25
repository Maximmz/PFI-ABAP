1. Dropdown Bindings (Master Data Strategy)

Every dropdown should map to a code + description master table.

🔹 Core Dropdowns
Field	CDS Entity	Key Fields
Model Name	Models	ID, name, description
Supplier	Suppliers	ID, name, country
Currency	Currencies	code (PK), description
Rate Type	RateTypes	code (Spot/Manual), description
Mode of Shipment	ShipmentModes	code, description
Inco-Term	IncoTerms	code (FOB, CIF), description
Port of Loading	Ports	ID, name, country
Port of Discharge	Ports	ID, name, country
Nature of Shipment	ShipmentNature	code, description
Payment	PaymentTerms	code (LC Sight, etc), description
PO Type	POTypes	code (Imported/Local), description
🔹 Optional / Derived Dropdowns
Field	Source
Item Code	Derived from Models
HS Code	Separate HSCodes master
Quotation No	Quotations entity
🧱 2. Data Model (CDS Entities)
📦 Core Transactional Tables
PerformaInvoices
entity PerformaInvoices {
  key ID                : UUID;
  pfiNumber             : String(50);
  supplier              : Association to Suppliers;
  currency              : Association to Currencies;
  quotation             : Association to Quotations;
  status                : String(20);
  pfiDate               : Date;
  validityDate          : Date;

  rateType              : Association to RateTypes;
  exchangeRate          : Decimal(15,4);

  paymentTerm           : Association to PaymentTerms;
  incoTerm              : Association to IncoTerms;
  shipmentMode          : Association to ShipmentModes;

  departureDate         : Date;
  arrivalDate           : Date;

  portOfLoading         : Association to Ports;
  portOfDischarge       : Association to Ports;
  shipmentNature        : Association to ShipmentNature;

  items                 : Composition of many InvoiceItems on items.invoice = $self;
}
InvoiceItems
entity InvoiceItems {
  key ID                : UUID;
  invoice               : Association to PerformaInvoices;

  model                 : Association to Models;
  itemCode              : String(50);
  description           : String(255);

  hsCode                : Association to HSCodes;

  lotSize               : Integer;
  quantity              : Integer;

  listPrice             : Decimal(15,2);
  unitPrice             : Decimal(15,2);

  noOfPO                : Integer;

  // Costing
  fobUnitPrice          : Decimal(15,2);
  localizationCost      : Decimal(15,2);
  localizationPercent   : Decimal(5,2);
  freightCost           : Decimal(15,2);
  discount              : Decimal(15,2);

  finalFOBRate          : Decimal(15,2);
  totalCFR              : Decimal(15,2);
  totalAmount           : Decimal(15,2);

  // Additional Info
  poType                : Association to POTypes;
  kitPerUnit            : Decimal(15,2);
  tbsPerUnit            : Decimal(15,2);
  tyrePerUnit           : Decimal(15,2);
}
📚 Master Data Tables

Example:

entity Suppliers {
  key ID    : UUID;
  name      : String(100);
  country   : String(50);
}
entity Currencies {
  key code  : String(3);
  name      : String(50);
}
entity IncoTerms {
  key code  : String(10);
  description : String(100);
}

👉 Repeat this structure for all dropdowns.

🔌 3. OData Service (service.cds)
service InvoiceService {

  entity PerformaInvoices as projection on db.PerformaInvoices;
  entity InvoiceItems     as projection on db.InvoiceItems;

  // Master Data
  entity Suppliers        as projection on db.Suppliers;
  entity Models           as projection on db.Models;
  entity Currencies       as projection on db.Currencies;
  entity RateTypes        as projection on db.RateTypes;
  entity ShipmentModes    as projection on db.ShipmentModes;
  entity IncoTerms        as projection on db.IncoTerms;
  entity Ports            as projection on db.Ports;
  entity ShipmentNature   as projection on db.ShipmentNature;
  entity PaymentTerms     as projection on db.PaymentTerms;
  entity POTypes          as projection on db.POTypes;
  entity HSCodes          as projection on db.HSCodes;
  entity Quotations       as projection on db.Quotations;
}
⚙️ 4. Behavior / Logic (Handlers)
📌 Auto-calculations (VERY IMPORTANT)

Implement in srv/handlers.js:

On CREATE/UPDATE InvoiceItems
// Pseudo logic
finalFOBRate = fobUnitPrice + localizationCost + freightCost - discount;

totalCFR = finalFOBRate * quantity;

totalAmount = totalCFR;
📌 Derived Fields
Field	Logic
Item Code	From Model
Localization %	(localization / FOB)
Exchange Rate	From rate service
🎯 5. Fiori Elements Binding
Value Help (Dropdown Binding)

Use annotations:

annotate InvoiceService.InvoiceItems with {
  model @Common.ValueList: {
    entity: 'Models',
    value: 'ID',
    label: 'name'
  };
};

Repeat for all dropdowns.

🚀 6. Implementation Plan (MD File)

Here’s your ready-to-copy .md file:

Writing
📘 CAP Implementation Plan – Performa Invoice System
1. Objective

Build a CAP-based backend for managing Performa Invoices with full master-data-driven dropdowns and automated pricing calculations.

2. Architecture
CAP (Node.js)
CDS for schema
OData V4 service
Fiori Elements UI
3. Modules
3.1 Master Data
Suppliers
Models
Currencies
Rate Types
Shipment Modes
Inco Terms
Ports
Shipment Nature
Payment Terms
PO Types
HS Codes
Quotations
3.2 Transactional Data
Performa Invoices (Header)
Invoice Items (Line Items)
4. Data Relationships
One Invoice → Many Items
Item → Model
Invoice → Supplier
Invoice → Currency
Invoice → Shipment Config
5. CDS Layers
db/schema.cds
All entities (Master + Transactional)
srv/service.cds
OData exposure
app/annotations.cds
Value helps
UI annotations
6. Business Logic
Calculations
Final FOB Rate
Total CFR
Total Amount
Hooks
Before Save
After Read (optional formatting)
7. Value Help Strategy

All dropdowns:

Use dedicated master tables
Bind via @Common.ValueList
8. Extensibility

Future enhancements:

Integration with S/4 APIs
Currency exchange API
Approval workflow
Print AFE generation
9. CI/CD

Optional:

cds build
cds test
deploy to BTP
10. Risks
Incorrect calculation logic
Missing master data
Poor value help performance
11. Next Steps
Create schema.cds
Seed master data
Implement service.cds
Add handlers
Generate Fiori app
Test end-to-end


