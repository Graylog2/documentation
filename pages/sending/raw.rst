********************
Ingest Raw/Plaintext
********************

The built-in *raw/plaintext* inputs allow you to parse any text that you can send via TCP or UDP. No parsing is applied at
all by default until you build your own parser using custom :doc:`extractors`. This is a good way to support any text-based
logging format.

You can also write :doc:`plugins` if you need extreme flexibility.