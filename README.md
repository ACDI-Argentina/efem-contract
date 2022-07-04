# Avaldao Smart Contract

Smart contract de Avaldao.

Se utiliza [Buidler](https://buidler.dev) como herramienta de ejecución de las tareas de compilación, testing y despliegue del smart contract.

En la sección [Architectural Decision Log](docs/adr/index.md) se encuentran los registros de decisiones de arquitectura que han sido tomadas.

## Requisitos sobre sistema operativo

### Windows

Instalar Python.

## Instalación de dependencias

Primero deben instalarse las dependencias del proyecto con el siguiente comando:

```
npm install
```

## Compilación

Para compilar el smart contract, debe ejecutarse el siguiente comando.

```
npm run compile
```

Se requiere mantener reducido el bytecode generado por el smart contract para no superar la restricción [EIP 170](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-170.md). El siguiente comando mide la cantidad de bytes generados para cada contrato compilado.

```
docker run -it -v C:\dev\acdi\project\avaldao-contract:/home ubuntu
cd home
grep \"bytecode\" artifacts/Aval* | awk '{print $1 " " length($3)/2}'
```

> La primera vez la compilación falla al no encontrar algunos smart contracts de Aragon, por ejemplo, es posible encontrarse con el siguiente error: *Error: BDLR700: Artifact for contract "Kernel" not found.* En este caso ejecutamos ```npm start```. Esto último a menudo muestra algún error, pero lo que importante es que compile los smart contracts faltantes. Una vez hecho esto volver a ejecutar ```npm run compile```.

## Testing

Para ejecutar los tests del smart contract, debe ejecutarse el siguiente comando.

```
npm run test
```

Los test se ejecutan por defecto sobre la blockchain *buidlerevm*.

## Publicar en NPM

Para que el módulo quede públicamente accecible y pueda utilizarse por los demás módulos de la aplicación, es necesario publicarlo de la siguiente manera:

```
npm login
npm publish --access public
```

El módulo se publica con el scope de la organización **@acdi**.

## Despliegue

Para desplegar el smart contract sobre la blockchain de RSK, debe ejecutarse el comando descrito según el ambiente.

Junto con el smart contract de Avaldao se despliegan los smart contract de Aragon y librerías por lo que este proceso puede demandar algunos minutos.

Las direcciones que aparecen en el log deben utilizarse para configurar la aplicación de Avaldao.

### Desarrollo

Si el entorno de desarrollo es Windows, instalar `win-node-env`.

```
npm install -g win-node-env
```

En desarrollo se utiliza un nodo local de **RSK Regtest** accesible desde *http://localhost:4444*.

```
npm run rsk-regtest:deploy
```

Opcionalmente, puede especificarse qué *DAO* o *Exchange Rate Provider* utilizar en el deploy:

```
$env:DAO_ADDRESS="..."
$env:EXCHANGE_RATE_PROVIDER_ADDRESS="..."
npm run rsk-regtest:deploy
```

- DAO_ADDRESS es la dirección del Aragon DAOdisponible desde el deploy inicial según la red.
- EXCHANGE_RATE_PROVIDER_ADDRESS es la dirección del *Exchange Rate Provider* a utilizar.

#### Proveer de fondos

Para provee de fondos a las cuentas en desarrollo, puede ejecutarse el siguiente script:

```
npm run rsk-regtest:found-accounts
```

#### Retirar fondos

Para retirar fondos desde el Fondo de Garantía, puede ejecutarse el siguiente script con la previa configuración de las variables `WITHDRAW_TOKEN`, `WITHDRAW_TO` y `WITHDRAW_VALUE` del archivo `/scripts/utils/.env.regtest`:

```
npm run rsk-regtest:withdraw
```

### Testing

En testing se utiliza el nodo público de **RSK Testnet** accesible desde *https://public-node.testnet.rsk.co*.

```
$env:DAO_ADDRESS="..."
$env:EXCHANGE_RATE_PROVIDER_ADDRESS="..."
npm run rsk-testnet:deploy
```
- DAO_ADDRESS es la dirección del Aragon DAOdisponible desde el deploy inicial según la red.
- EXCHANGE_RATE_PROVIDER_ADDRESS es la dirección del *Exchange Rate Provider* a utilizar.

#### Retirar fondos

Para retirar fondos desde el Fondo de Garantía, puede ejecutarse el siguiente script con la previa configuración de las variables `WITHDRAW_TOKEN`, `WITHDRAW_TO` y `WITHDRAW_VALUE` del archivo `/scripts/utils/.env.testnet`:

```
npm run rsk-testnet:withdraw
```

### Producción

En testing se utiliza el nodo público de **RSK Mainnet** accesible desde *https://public-node.rsk.coo*.

```
$env:DAO_ADDRESS="..."
$env:EXCHANGE_RATE_PROVIDER_ADDRESS="..."
npm run rsk-mainnet:deploy
```
- DAO_ADDRESS es la dirección del Aragon DAOdisponible desde el deploy inicial según la red.
- EXCHANGE_RATE_PROVIDER_ADDRESS es la dirección del *Exchange Rate Provider* a utilizar.

## Actualizar smart contract

Para actualizar el smart contract debe ejecutarse el siguiente script, especificando los parámetros:

```
$env:BUIDLER_NETWORK="..."
$env:DAO_ADDRESS="..."
node .\scripts\upgrade.js
```

- BUIDLER_NETWORK = rskRegtest | rskTestnet | rskMainnet
- DAO_ADDRESS es la dirección del Aragon DAOdisponible desde el deploy inicial según la red.

Este scrtip es genérico para una actualización. Las actualización generalmente siguen scrtip específicos según los cambios en la versión. A continuación se lista los upgrades.

## Otorgar permisos

Para otorgar permisos debe ejecutarse el siguiente script, especificando los parámetros:

```
$env:BUIDLER_NETWORK="..."
$env:DAO_ADDRESS="..."
$env:AVALDAO_CONTRACT_ADDRESS="..."
$env:ACCOUNT_ADDRESS="..."
$env:ROLE="..."
node .\scripts\grant-permission.js
```
- BUIDLER_NETWORK = rskRegtest | rskTestnet | rskMainnet
- DAO_ADDRESS es la dirección del Aragon DAO disponible desde el deploy inicial según la red.
- AVALDAO_CONTRACT_ADDRESS es la dirección del smart contract de Avaldao.
- ACCOUNT_ADDRESS es la dirección pública de la cuenta a la cual se otorga el permiso.
- ROLE = ROLE

#### Retirar fondos

Para retirar fondos desde el Fondo de Garantía, puede ejecutarse el siguiente script con la previa configuración de las variables `WITHDRAW_TOKEN`, `WITHDRAW_TO` y `WITHDRAW_VALUE` del archivo `/scripts/utils/.env.mainnet`:

```
npm run rsk-mainnet:withdraw
```

## Principios de desarrollo

Para el desarrollo del smart contract se deben seguir los siguientes principios:

- Seguir la [guía de estilos](https://solidity.readthedocs.io/en/v0.6.11/style-guide.html) de desarrollo de Solidity.
- El orden los metodos debe ser: *external*, *public*, *internal* y *private*; Deben seguir un orden de relevancia.
- Siempre que sea posible, el tratamiento sobre las entidades debe delegarse en las librerías para mantener el bytecode del smart contract reducido.
- Sebe realizarse testing automático de las funcionalidades expuestas al exterior.