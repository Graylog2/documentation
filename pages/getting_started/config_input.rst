Configure Graylog Input
^^^^^^^^^^^^^^^^^^^^^^^

By default - to have something to look at, the Appliance is already getting logs. This are the Logfiles from all components that are running inside. This can be disabled later the :ref:`graylog-ctl`.

If you check your Graylog in your Browser and click in *System > Inputs* you see that two Inputs are already present.

.. image:: /images/gs/input_page.png

We will create a new input, select in *Syslog TCP* in the Dropdown and click on *Launch new input*.


Go back to the Graylog console open in your browser and click *System -> Inputs*.  Then select Syslog UDP and click *Launch* new input.  Fill out the circles with the values in the screen shown below.

.. image:: /images/gs_8-inputstart.png

