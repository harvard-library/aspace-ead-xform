# aspace-ead-xform
Transform an EAD via XSLT in various ways

Using a generated EAD, apply XSLT transforms to it.

V1.0.0: create a "staff side" CSV for a Resource [Collection]

The initial "staff side" CSV is designed to match the CSV created from Harvard's OASIS system, which is due to be retired.
Currently, the CSV does **not** include unpublished components, to match that functionality.

This plugin will begin life on the ArchivesSpace `/frontend`; subsequent use of the core transform class may need to be duplicated on the `/public` side as well.

