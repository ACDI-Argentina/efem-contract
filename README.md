# El Futuro está en el Monte Smart Contract

Smart contract de El Futuro está en el Monte.

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