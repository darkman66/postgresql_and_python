Installing and compiling all the necessary modules step by step.

# Python

Download python source code

    wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tgz
    
Compile it. Warning, Please pay attntion about --enable-shared flag!

    ~/stuff/Python-2.7.10% ./configure —PREFIX=/opt/py --enable-shared

If you try to run Python and you're getting this kind of error

    py ➤ bin/python2.7
    bin/python2.7: error while loading shared libraries: libpython2.7.so.1.0: cannot open shared object file: No such file or directory

Ten you need to add lib path of your newly compiled python to system lib path

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/py/lib

    
# PostgreSQL

Download

    wget https://ftp.postgresql.org/pub/source/v9.4.4/postgresql-9.4.4.tar.bz2
    
Compile with python support and Python from out /opt/py directory

    ./configure --prefix=/opt/pgsql —with-python PYTHON=/opt/py/bin/python
    make
    make install
    
Now compile and install plugins

    cd ~/stuff/postgresql-9.4.3/contrib
    make
    make install
    
    
# Creating empty DB

Now it is time to start PostgreSQL. First initialize name space

    mkdir /opt/pg_data
    /opt/pgsql/bin/initdb /opt/pg_data

and start DB...

    /opt/pgsql/bin/postmaster -p 5432 -D /opt/pg_data/
    
Create new DB.

    /opt/pgsql/bin/createdb -h localhost  -E utf8 pie
    
Please rememebr about the correct encoding for DB! Now create new language for database pie

    /opt/pgsql/bin/createlang -h localhost  -d pie plpythonu
    

# Inserting data

First you have to create structure of the database

    ➜  postgresql_and_python git:(master) psql -h localhost pie < tables.sql
    
Next insert fake data

    ➜  postgresql_and_python git:(master) psql -h localhost pie < data.sql
    
Now in the same way insert functions one by one from the reposiroey (just skip steps.sql file)


Have fun!
