# JavascriptAutoInclude

## Important note

This plugin it no longer maintained, I recommend using the [Sprockets gem](http://github.com/sstephenson/sprockets) which allows you to maintain separate javascript files for easy development while concatenating them into one file at run time to best utilise browser caching. If you still wish to use this plugin and want to make changes please fork a copy.

## Installation

    * On rails 2.1 and above run
    script/plugin install git://github.com/kernow/javascript_auto_include.git
 
## Usage

Add the following to the head of your template file

    <%= javascript_auto_include_tags %>
 
Now each time the template is loaded javascript files in the public/javascripts/views
folder that correspond to the name of the current controller or view will be auto
loaded. It's also possible for the same javascript file to be loaded by multiple views
by adding the name of each view to the filename separated by the "-" character, e.g. to load
a javascript file in the new and edit views create a file named new-edit.js. Any number
of views can be strung together using this naming convention. For example:

    /public
     /javascripts
       /views
         users.js
         /users
           edit.js
         roles.js
         /accounts
           show-new-edit-create.js
    	 show.js

Assuming the above file structure loading each of the following urls would include:
 
    mydomain.com/users             # includes users.js
    mydomain.com/users/edit/1      # includes users.js and edit.js
    mydomain.com/users/show/1      # includes users.js
    mydomain.com/roles             # includes roles.js
    mydomain.com/accounts          # no files included
    mydomain.com/accounts/show/1   # includes show.js and show-new-edit-create.js
    mydomain.com/accounts/new      # includes show-new-edit-create.js
    mydomain.com/accounts/edit/1   # includes show-new-edit-create.js
    mydomain.com/accounts/create   # includes show-new-edit-create.js

## More

[http://kernowsoul.com/page/javascript_auto_include](http://kernowsoul.com/page/javascript_auto_include)

## Acknowledgements 

 Thanks to geoffgarside http://github.com/geoffgarside for also creating a version that can
 include the same file in multiple views. Some of the code comments are from his version as
 they are more concise than mine.