> A batteries-included Django starter project. To learn more visit [LearnDjango.com](https://learndjango.com).


https://github.com/wsvincent/djangox/assets/766418/a73ea730-a7b4-4e53-bf51-aa68f6816d6a


## 🚀 Features

- Django 5.0 & Python 3.12
- Install via [Pip](https://pypi.org/project/pip/) or [Docker](https://www.docker.com/)
- User log in/out, sign up, password reset via [django-allauth](https://github.com/pennersr/django-allauth)
- Static files configured with [Whitenoise](http://whitenoise.evans.io/en/stable/index.html)
- Styling with [Bootstrap v5](https://getbootstrap.com/)
- Debugging with [django-debug-toolbar](https://github.com/jazzband/django-debug-toolbar)
- DRY forms with [django-crispy-forms](https://github.com/django-crispy-forms/django-crispy-forms)
- Custom 404, 500, and 403 error pages
----

## Table of Contents
* **[Installation](#installation)**
  * [Pip](#pip)
  * [Docker](#docker)
* [Next Steps](#next-steps)
* [Contributing](#contributing)
* [Support](#support)
* [License](#license)

----

## 📖 Installation
DjangoX can be installed via Pip or Docker. To start, clone the repo to your local computer and change into the proper directory.

```
$ git clone https://github.com/wsvincent/djangox.git
$ cd djangox
```

### Pip

```
$ python -m venv .venv

# Windows
$ Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
$ .venv\Scripts\Activate.ps1

# macOS
$ source .venv/bin/activate

(.venv) $ pip install -r requirements.txt
(.venv) $ python manage.py migrate
(.venv) $ python manage.py createsuperuser
(.venv) $ python manage.py runserver
# Load the site at http://127.0.0.1:8000
```

### Docker

To use Docker with PostgreSQL as the database update the `DATABASES` section of `django_project/settings.py` to reflect the following:

```python
# django_project/settings.py
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "postgres",
        "USER": "postgres",
        "PASSWORD": "postgres",
        "HOST": "db",  # set in docker-compose.yml
        "PORT": 5432,  # default postgres port
    }
}
```

The `INTERNAL_IPS` configuration in `django_project/settings.py` must be also be updated:

```python
# config/settings.py
# django-debug-toolbar
import socket
hostname, _, ips = socket.gethostbyname_ex(socket.gethostname())
INTERNAL_IPS = [ip[:-1] + "1" for ip in ips]
```

And then proceed to build the Docker image, run the container, and execute the standard commands within Docker.

```
$ docker-compose up -d --build
$ docker-compose exec web python manage.py migrate
$ docker-compose exec web python manage.py createsuperuser
# Load the site at http://127.0.0.1:8000
```

## Next Steps

- Add environment variables. There are multiple packages but I personally prefer [environs](https://pypi.org/project/environs/).
- Add [gunicorn](https://pypi.org/project/gunicorn/) as the production web server.
- Update the [EMAIL_BACKEND](https://docs.djangoproject.com/en/4.0/topics/email/#module-django.core.mail) and connect with a mail provider.
- Make the [admin more secure](https://opensource.com/article/18/1/10-tips-making-django-admin-more-secure).
- `django-allauth` supports [social authentication](https://django-allauth.readthedocs.io/en/latest/providers.html) if you need that.

I cover all of these steps in tutorials and premium courses over at [LearnDjango.com](https://learndjango.com).

----

## 🤝 Contributing

Contributions, issues and feature requests are welcome! See [CONTRIBUTING.md](https://github.com/wsvincent/djangox/blob/master/CONTRIBUTING.md).

## ⭐️ Support

Give a ⭐️  if this project helped you!

## License

[The MIT License](LICENSE)






From chatgpt
Q: How do i change mynew django projects sqlite3 database to postgres?

A: To switch your Django project from using SQLite to PostgreSQL, follow these steps:

1. **Install PostgreSQL and psycopg2:**
   Make sure PostgreSQL is installed on your system. You'll also need the `psycopg2` library, which allows Django to interact with PostgreSQL. Install it using pip:

   ```bash
   pip install psycopg2-binary
   ```

2. **Update Django settings:**
   Open your `settings.py` file and locate the `DATABASES` setting. You'll need to modify it to use PostgreSQL. Change it from the default SQLite configuration to something like this:

   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.postgresql',
           'NAME': 'your_database_name',
           'USER': 'your_database_user',
           'PASSWORD': 'your_database_password',
           'HOST': 'localhost',  # Set to your database host if different
           'PORT': '5432',       # Default port for PostgreSQL
       }
   }
   ```

   Replace `'your_database_name'`, `'your_database_user'`, and `'your_database_password'` with your PostgreSQL database's actual credentials.

3. **Create the PostgreSQL database:**
   You'll need to create the database in PostgreSQL that matches the `NAME` you specified in `settings.py`. You can do this via the PostgreSQL command line or a graphical tool like pgAdmin.

   Using the PostgreSQL command line, you might do something like this:

   ```bash
   psql -U postgres
   ```

   Then, in the PostgreSQL prompt:

   ```sql
   CREATE DATABASE your_database_name;
   CREATE USER your_database_user WITH PASSWORD 'your_database_password';
   ALTER ROLE your_database_user SET client_encoding TO 'utf8';
   ALTER ROLE your_database_user SET default_transaction_isolation TO 'read committed';
   ALTER ROLE your_database_user SET timezone TO 'UTC';
   GRANT ALL PRIVILEGES ON DATABASE your_database_name TO your_database_user;
   ```

4. **Migrate your database:**
   Run Django’s migration commands to create the necessary database schema in PostgreSQL:

   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

5. **Transfer existing data (if needed):**
   If you have existing data in your SQLite database that you want to transfer to PostgreSQL, you can use a tool like `django-admin` to dump data to JSON and then load it into PostgreSQL. For example:

   - Dump data from SQLite:

     ```bash
     python manage.py dumpdata > db.json
     ```

   - Load data into PostgreSQL:

     ```bash
     python manage.py loaddata db.json
     ```

   Ensure that the `db.json` file is compatible with your PostgreSQL database and adjust if needed.

6. **Test your setup:**
   Run your Django development server and check if everything is working correctly with the PostgreSQL database.

   ```bash
   python manage.py runserver
   ```

By following these steps, you should be able to switch your Django project from SQLite to PostgreSQL smoothly. If you encounter any issues, checking the Django documentation or PostgreSQL logs can help troubleshoot the problem.






Q: How do I do step 3?

A: Got it! If you need to create a PostgreSQL database that matches the `NAME` specified in your `settings.py`, here’s how you can do it using both the command line and pgAdmin:

### **1. Creating the PostgreSQL Database via the Command Line**

1. **Switch to the PostgreSQL User**:

   Open a terminal and switch to the `postgres` user:

   ```bash
   sudo -i -u postgres
   ```

2. **Access the PostgreSQL Command Line**:

   Enter the PostgreSQL interactive terminal:

   ```bash
   psql
   ```

3. **Create the Database**:

   Use the `CREATE DATABASE` command to create the database. Replace `postgres` with the database name specified in your `settings.py`:

   ```sql
   CREATE DATABASE postgres;
   ```

4. **Create the User** (if needed):

   If you need to create a new PostgreSQL user with the same name as in `settings.py`, use:

   ```sql
   CREATE USER postgres WITH PASSWORD 'postgres';
   ```

5. **Grant Privileges**:

   Grant the necessary privileges to the user:

   ```sql
   GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;
   ```

6. **Exit PostgreSQL**:

   Exit the interactive terminal:

   ```sql
   \q
   ```

7. **Exit the `postgres` User**:

   ```bash
   exit
   ```


### **Confirming the Configuration**

- **Check the `settings.py`**: Make sure that the `DATABASES` setting in `settings.py` matches the database and user credentials you’ve created:

   ```python
   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.postgresql',
           'NAME': 'postgres',     # Should match the database name created
           'USER': 'postgres',     # Should match the user created
           'PASSWORD': 'postgres', # Should match the user's password
           'HOST': 'localhost',    # Use 'db' if you're in Docker
           'PORT': 5432,           # Default PostgreSQL port
       }
   }
   ```

- **Test the Connection**: After setting up, you can test the connection to ensure everything is configured correctly by running:

   ```bash
   python manage.py migrate
   ```

   This command will apply migrations and ensure Django can connect to PostgreSQL.

By following these steps, you should be able to create the PostgreSQL database and user, ensuring they align with the credentials specified in your Django project’s settings.