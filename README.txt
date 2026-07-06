=======================================
  Store Website - Setup Instructions
=======================================

TOOLS NEEDED:
  - Java 8 (JDK 1.8)
  - GlassFish Server (4.x or 5.x)
  - MySQL Server
  - MySQL Connector/J (JDBC driver JAR)

-----------------------------------------
STEP 1: Setup MySQL Database
-----------------------------------------
  1. Open MySQL command line or MySQL Workbench
  2. Run the file: database.sql
     Command: mysql -u root -p < database.sql
  3. This creates database "store" and table "product_list" with 3 rows.

-----------------------------------------
STEP 2: Add MySQL JDBC Driver
-----------------------------------------
  1. Download mysql-connector-java-5.1.49.jar (or similar)
  2. Copy it to: GlassFish/domains/domain1/lib/
  3. Restart GlassFish after copying.

  OR if using NetBeans/Eclipse:
  - Add the JAR to your project's WEB-INF/lib/ folder.

-----------------------------------------
STEP 3: Update DB Password (if needed)
-----------------------------------------
  Open Products.jsp and change this line:
    String pass = "";
  to your MySQL root password, e.g.:
    String pass = "your_password";

-----------------------------------------
STEP 4: Deploy and Run
-----------------------------------------
  1. Copy the "web" folder contents to GlassFish deployment.
  2. OR create a WAR file and deploy via GlassFish admin console.
  3. Open browser: http://localhost:8080/StoreWebsite/

-----------------------------------------
PROJECT STRUCTURE:
-----------------------------------------
  web/
    Home.jsp         - Welcome page with product list
    Products.jsp     - Shows products from database
    OrderForm.jsp    - Order form (display only)
    css/
      style.css      - External CSS (light green nav, light yellow content)
    WEB-INF/
      web.xml        - Deployment descriptor
  database.sql       - MySQL setup script
  README.txt         - This file
