# E-commerce Web Application

This project is a comprehensive shoe e-commerce web application built using ASP.NET MVC 5. It offers a user-friendly interface for browsing, searching and purchasing shoes online.

## Key Features

![Home page](/Screenshots/home_page.png)

- User Authentication: Allow register account, login, recover password, change password.
- Product Catalog: Detailed listing of various shoe products and accessories.
- Shopping Cart: Add, update and remove items from the cart.
- Checkout Process: Seamless checkout with order summary.
- Admin Panel: Manager products, categories and user orders efficiently.

## Technologies Used

- Langueages/Platforms: C#, ASP.NET MVC 5, IIS, Visual Studio.
- Databases: MySQL.
- Others:Bootstrap 4, jQuery, DataTables, SweetAlert.

## Getting Started

### System requirements

- Windows 10 (or higher)
- MySQL 8.0+
- Visual Studio 2022

### Build and run

To run this project locally, follow these steps:

- Clone the repository using the command `git clone https://github.com/ntandat64dev/sneaker-store.git` and switch to the `main` branch using `git switch main`.
- Download Visual Studio 2022 from: https://visualstudio.microsoft.com/downloads/
- Open `CuoiKyDotNet.sln` and wait for Visual Studio to restore all NuGet packages.
- Create a MySQL database named `sneaker` and run `script.sql` file for schema creation and generate some initial data. You change the username and password in `Data/Database/DbConnection.cs`, this is the default configurations:
	```java
	private const string HOST = "127.0.0.1";
    private const int PORT = 3306;
    private const string USERNAME = "root";
    private const string PASSWORD = "0000";
    private const string DATABASE = "sneaker";
	```
- Make sure `App` is the startup project and run it.