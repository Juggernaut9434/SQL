# Application Development

Databases are only a single layer of the application.
On a Client - Server relationship.
usually done with a GUI or terminal.

Instead of every patron of the library coming in and writing queries to find a book, the software has abstracted that into a simple search bar by adding layers to the application. 

Common separation of application code

1. Presentation Tier (front end)
2. Logic Tier 
3. Data Tier (database)

Benefits

- Changing and upgrading layers without affecting the others
- layers can be scaled if needed without scaling all of them.
- Each layer can have its own security 

#### Communication

Instead of an end user interacting with the database,
the logic tier does.
It still needs a login and password
and can have permissions to certain schemas etc.

Therefore:

- logic tier is just another client to the db
- logic tier can perform functions and procedures
- multiple additions or modifications can be wrapped in transactions
- funnels all through the logic tier to create a fine tuned experience for the front end.


## PostgreSQL and PHP (Apache)

- `pg_connect("host=pg_db_server, port=5432, dbname=postgres, user=postgres, password=Adam123456");` to connect the webserver to the db
- `pg_query("ANY QUERY IN HERE");` to query the db
- Look at documentation for php postgres functions

Instead of direct connect, you can use php variables `$foo`
for pg_connect and the sql query to then use it in

- `pg_query($db_connection, $sql_query);`
- `pg_close($db_connection);`


#### To deal with results from queries

under a for each loop for each row,
`$sku = pg_fetch_result($result, $row, 'sku');` 
grabs the sku. 
You can then add it to a table.

```php
<tr>
	<td>" . $sku . "</td>
</tr>

```

#### Choose what kind of info coming back

using the `$_POST['variable_name']` will pull a variable from a select
from the form control in the html with the `name=variable_name`

```php
// and then use it here
$result = pg_prepare($db_connection, "my_query", 
	'SELECT sku, product_name, category_id, size, price
 		FROM inventory.products
		WHERE category_id = $1;');

$result = pg_execute($db_connection, "my_query", array($_POST['category_id_value']));

```

#### Add data

similar to the selecting of info with the name selector,

```php
$result = pg_prepare($db_connection, "my_query", 
	'INSERT INTO inventory.products (sku, product_name, category_id, size, price)
		VALUES ($1, $2, $3, $4, $5);'
);
    
$result = @pg_execute($db_connection, "my_query", array(
	$_POST['sku_value'],
    $_POST['name_value'],
    $_POST['category_id_value'],
    $_POST['size_value'],
    $_POST['price_value']
	)
);

```

The @ symbol will cause any errors that may be generated to be ignored.


## SQL Server and ASP.NET Core

#### MVC Modelling and Modularity

ASP.NET Core is MVC and is very Module heavy.

- Controller: 
	- they handle client requests
	- work with the model
	- determine views that is returned to client
- View:
	- create the UI by organizing data passed from controller
- Model:
	- represent the data within the app
	- interface with a database to store and retrieve information 
	- enforce business logic

#### Making the server

Look at the folder `ASP.NET` and the files within:

these files allow the docker to use just `docker compose` command
instead of running multiple files on docker

#### Need to create the database externally

either in Azure Data Studio or on the command line 
for that sql server

#### Connecting ASP.NET and SQL Server

- in `appsettings.json` under ConnectionStrings : AbbDbContext
	- gives the db name and the connection configuration
- in `Startup.cs` there is a line that specifies the type of connection

```cs
// Startup.cs, Startup : ConfigureServices
services.AddDbContext<ApplicationDbContext>(options =>
	options.UseSqlServer(Configuration.GetConnectionString("AppDbContext")));
```

- in `Data/ApplicationDbContext.cs` describes what is inside the database
and what is available dataset (table)
- to describe the columns of the tables, they are in `Model/Customer.cs`
where the `public string customer_id` is the name in the db
that have constraints laid out as prefixes to that line

#### Controllers

Link between the model and the views (database and the UI)

To view the View, go to `/View/.` and specifically `/View/Customers/Index.cshtml`

For Controllers, they handle the actual sending of API requests to the database.
they have special formatting

```cs
// GET: Customers/Details/5
public async Task<IActionResult> Details(int? id)
{
    if (id == null)
    {
        return NotFound();
    }

    var customer = await _context.Customer
        .FirstOrDefaultAsync(m => m.Id == id);
    if (customer == null)
    {
        return NotFound();
    }

    return View(customer);
}

// GET: Customers/Create
public IActionResult Create()
{
    return View();
}

// POST: Customers/Create
// To protect from overposting attacks, enable the specific properties you want to bind to.
// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
[HttpPost]
[ValidateAntiForgeryToken]
public async Task<IActionResult> Create([Bind("Id,customer_id,company,address,city,state,zip")] Customer customer)
{
    if (ModelState.IsValid)
    {
        _context.Add(customer);
        await _context.SaveChangesAsync();
        return RedirectToAction(nameof(Index));
    }
    return View(customer);
}
```

#### URL Segments

The url changes frequently to match the view that is displayed.
Same for quieried, parameter fields in the url

The segmenting of the endpoint mapping is controlled in the `Startup.cs`


#### SQLCMD

it is a command line tool for SQL Server 

