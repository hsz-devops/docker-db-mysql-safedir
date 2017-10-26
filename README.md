This image tries to make sure that we only accept empty or uninitialized database
when we know we are initializing. It also checks that the target folder has a tag-file.

The goal is to prevent scenarios where:
- we start working with an empty DB instead of an existing DB
- we start working with the wrong DB for this container

We have 2 options for tag-id marker:
- "single" file, fixed name, variable content (that needs to match an env variable)
- "multi" files, fixed prefix, variable suffix (possibly matched with env var);
  content of each checked against env variable

Single file prevents accidental use by 2 containers, and makes it harder to migrate (need to remove/change the file).
Multiple files allow for easier migration between containers (less strict prevention) and causes more pollution
