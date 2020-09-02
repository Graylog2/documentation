******************************
Ingest JSON path from HTTP API
******************************

The JSON path from HTTP API input is reading any JSON response of a REST resource and stores a field value of it as a Graylog message.

Navigate :
----------
System/Inputs -> Inputs -> Select `Launch JSON path from HTTP API`, click `Launch Input`, set significant field values and `save` Input ::

    source = github ,jsonpath = $.download_count, interval time unit = Minutes

Example
-------

Let's try to read the download count of a release package stored on GitHub for analysis in Graylog. The call looks like this::

    $ curl -XGET https://api.github.com/repos/YourAccount/YourRepo/releases/assets/12345
    {
      "url": "https://api.github.com/repos/YourAccount/YourRepo/releases/assets/12345",
      "id": 12345,
      "name": "somerelease.tgz",
      "label": "somerelease.tgz",
      "content_type": "application/octet-stream",
      "state": "uploaded",
      "size": 38179285,
      "download_count": 9937,
      "created_at": "2013-09-30T20:05:01Z",
      "updated_at": "2013-09-30T20:05:46Z"
    }

The attribute we want to extract is ``download_count`` so we set the JSON path to ``$.download_count``.

This will result in a message in Graylog looking like this:

.. image:: /images/jsonpath_1.png

You can use Graylog to analyze your download counts now.

JSONPath
--------

JSONPath can do much more than just selecting a simple known field value. You can for example do this to select the first ``download_count``
from a list of releases where the field ``state`` has the value ``uploaded``::

    $.releases[?(@.state == 'uploaded')][0].download_count

...or only the first download count at all::

    $.releases[0].download_count


You can `learn more about JSONPath here <http://goessner.net/articles/JsonPath/>`__.