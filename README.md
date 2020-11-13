<img src="https://oasislmf.org/packages/oasis_theme_package/themes/oasis_theme/assets/src/oasis-lmf-colour.png" alt="Oasis LMF logo" width="250"/>

# ComplexModelMDK

## Run complex model example via MDK
* Install MDK dependent packages, for ubuntu

```
sudo apt-get update && sudo apt-get install libspatialindex-dev unixodbc-dev build-essential libtool zlib1g-dev autoconf
```

* Install OasisLMF and other required packages:

  ```
  pip install -r requirements.txt
  ```

* Install the custom item commands and the example custom GulCalc:

  ```
  pip install -e .
  ```

* Run the MDK commands using either implicit calling of the installed package or the explicit specification of a supplier model runner, for example:

  ```
  oasislmf model run -C oasislmf_implicit.json --verbose

  oasislmf model run -C oasislmf_explicit.json --verbose
  ```

## Run the complex model example using the API & UI
1) install git, docker and docker-compose

For example on an Ubuntu/Debian based Linux system use:
```
sudo apt update && sudo apt install git docker docker-compose
```

2) Clone this repository
```
git clone https://github.com/OasisLMF/ComplexModelMdk.git
cd ComplexModelMdk
```
3) Run the deployment script
```
sudo ./install.sh
```

4) Access via localhost, using the default `user: admin` `pass: password`
* [OasisUI Interface](http://localhost:8080/app/BFE_RShiny) - *localhost:8080/app/BFE_RShiny* 
* [API Swagger UI](http://localhost:8000/) - *localhost:8000*
* [API Admin Panel](http://localhost:8000/admin) - *localhost:8000/admin*


### Notes: 
* Gulcalc python class [complex_model/OasisLMF_ComplexModelExample_gulcalc.py](https://github.com/OasisLMF/ComplexModelMDK/blob/master/complex_model/OasisLMF_ComplexModelExample_gulcalc.py)
* Lookup python class [complex_model/DummyComplexModelKeysLookup.py](https://github.com/OasisLMF/ComplexModelMDK/blob/master/complex_model/DummyComplexModelKeysLookup.py)
* Example test data [tests/data](https://github.com/OasisLMF/ComplexModelMDK/tree/master/tests/data)
* Example model params for the UI [model_resource.json](https://github.com/OasisLMF/ComplexModelMDK/blob/master/model_resource.json)
