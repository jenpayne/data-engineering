# Configuration Instructions
1.  The project is configured to use rbenv.  If using rbenv, install ruby 2.0.0-p0 by typing `rbenv install 2.0.0-p0` at the command line. 
2.  If not using rbenv, verify that you have ruby 2.0.0-p0 installed (use rvm or system ruby)
3.  run `bundle` to install required gems
4.  Run `rake db:create && rake db:migrate` to create and migrate the database.  **Please note**:  If you have data\_engineering\_development or data\_engineering\_test databases already existing, please rename the databases in `config/database.yml` for this application.
5.  At the command line, run `bundle exec rails s` to start the rails server.
6.  Open a browser window and navigate to `http://localhost:3000` to use the application.

## Notes and Considerations

There are two branches.  Master and open\_id.  The open\_id branch works via authentication with Google.  If you wish to not use any authentication, master does the trick.

If you've already imported a data file, the application will not let you import it again.  This is determined via hashing.  Any slight change to the data will allow it to be uploaded as the file hash will change.

I had some reservations about including the price in the Item model as it seems that it may be possible (although not reflected in the example data) that a description could potentially be the same but with a different price.  If that's the case, I would put it in the Purchase model.  However, I went with what the example data appeared to do (reflect the price in description) and made the price a part of the Item model.

Normally I would use a Postgres database, however for ease of set-up I opted for sqlite.