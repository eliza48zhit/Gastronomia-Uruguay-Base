// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaUruguay
 * @dev Registro historico con Likes, Dislikes e Identificador de Punto de Coccion.
 */
contract GastronomiaUruguay {

    struct Plato {
        string nombre;
        string descripcion;
        string puntoCoccion; // Ej: A Punto, Jugoso, Cocido, Al Dente
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el Chivito Uruguayo
        registrarPlato(
            "Chivito", 
            "Sandwich de lomo de res con jamon, queso, huevo, tocino y ensalada.",
            "A Punto"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _puntoCoccion
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            puntoCoccion: _puntoCoccion,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory puntoCoccion,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.puntoCoccion, p.likes, p.dislikes);
    }
}
