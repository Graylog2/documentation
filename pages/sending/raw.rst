********************
Ingest Raw/Plaintext
********************

The built-in ``RAW/Plaintext`` input is a netcat like application in Graylog. It will receive any data that is ingested into the running input. 

The advantage is that this data is parsable with the extractors or the processing pipeline. But as no structure is known, Graylog will not automatically extract the time or any other information from the log. 

This way of working is useful for debugging. You can check what kind of log a specific appliance or application sent. 

Sometimes the ``RAW/Plaintext`` is the best option to ingest logs from applications or scripts into Graylog. 
