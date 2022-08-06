pragma solidity ^0.4.24;

/**
 * @title Constantes de EFEM.
 * @author ACDI
 */
contract EfemConstants {
    // Grupos

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    // Permisos

    bytes32 public constant SET_EXCHANGE_RATE_PROVIDER_ROLE =
        keccak256("SET_EXCHANGE_RATE_PROVIDER_ROLE");
    bytes32 public constant ENABLE_TOKEN_ROLE = keccak256("ENABLE_TOKEN_ROLE");
}
