# MusiCat

music catalog publishing and management

**Albums • Articles • Audio • Events • Pictures • Videos**

host your own content on your own server (not included)


## Requirements

- a server
- Ruby
- Rails

has been used in production with
- debian
- postgresql
- sqlite3
- unicorn
- nginx


## Getting Started

*This summary presumes a familiarity with Ruby-on-Rails apps.*

1. Install software
    - `bundle install`

2. Initialize a database
    - `rails db:setup`

3. Generate secret key
    - `rails credentials:edit`

4. Create an administrator account.
    - `rails musicat:administrator:new`


## Media Content

### Upload

Transfer files in the app.

### Import

Transfer files to the server using scp, and reference in the app.

  - portfolio directory declared in `config/initializers/x_musicat.rb`
    - `source_imported_filesystem_dirname`
    - default is `public/portfolio`
    - can symlink `public/portfolio` to outside portfolio directory
    - can use web server location rules to point url directly to portfolio directory (bypass rails)

### Embed

Additional option only for videos. Use an `<iframe>` tag from a different platform. Remove `width=` and `height=` attributes if possible.

## Features

- desktop and mobile
- dark and light modes
- collect media by keywords
- use plain text or markdown

## Caveats

Videos, even embedded videos, require a coverpicture for the videos index.

Be sure the `source_type` attribute matches the inclusion method (upload/import/embed).

On its fourth of nine lives. Contains bugs, incomplete features, and legacy code. Please keep a backup of your data. Usage considered functional, but still experimental. Questions and constructive experience reports welcome.

Support is limited. No guarantees or warranties.
