**************************
Upgrading to Graylog 2.4.x
**************************

.. _upgrade-from-23-to-24:

More plugins shipped by default
===============================

The following Graylog plugins are now shipped as part of the Graylog server release.

- AWS Plugin - https://github.com/Graylog2/graylog-plugin-aws
- Threat Intelligence Plugin - https://github.com/Graylog2/graylog-plugin-threatintel
- NetFlow Plugin - https://github.com/Graylog2/graylog-plugin-netflow
- CEF Plugin - https://github.com/Graylog2/graylog-plugin-cef

Make sure you remove all previous versions of these plugins from your ``plugin/``
before starting the new Graylog version!
