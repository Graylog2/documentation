.. _search_parameters:

Parameters
----------

Complex searches queries sometimes require defining a value multiple times. Especially changing this value can be demanding.
Parameters are very helpful in this scenario. They allow the usage of a placeholder which can be used as many times as needed.

.. image:: /images/searching/parameter_example.png
   :align: center

.. important:: Parameters are an Enterprise Integrations plugin feature and thus requires an :ref:`Enterprise license <enterprise_features>`.

Declaring a parameter
^^^^^^^^^^^^^^^^^^^^^
Parameters can be added wherever you want to perform a search, no matter if saved searches, dashboards or the main search page.
To create a parameter just open the sidebar section `Create` and select the option `Parameter`.

.. image:: /images/searching/parameter_creation_step1.png
   :align: center

This will open a modal with the following options.

.. image:: /images/searching/parameter_creation_step2.png
   :align: center

* Name: The name of the placeholder you will use inside your query. It will represent the value.
* Title: The title will be displayed beside the parameter declaration input. 
* Description: While the title should describe the parameters purpose, the description allows defining a more complex explanation.
* Default: The value which will be used by default for the parameter. More on this in the next section.

After clicking on `Submit` you will be able to implement the parameter inside your query with the syntax `$parameterName$`.

Default values
^^^^^^^^^^^^^^
When using parameters you always need to define a value for every parameter. Otherwise the query is not appropriate and the search can not be executed.
With default paramter values, the search will always be executable, unless you remove a value manually.

When opening a dashboard or saved search you will see the following dialog first, if a configured parameter has no default value.

.. image:: /images/searching/parameter_dashboard_dialog.png
   :align: center
