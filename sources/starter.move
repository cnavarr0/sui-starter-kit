module starter::biblioteca{
    use std::string::{String}
    use sui::vec_map::{VecMap};

    public struct Biblioteca has key{
        id: UID,
        nombre: String,
        libros: VecMap<u64, Libro>,
    }

    public struct Libro has store{
        titulo: String,
        autor: String,
        publicacion: u16,
        disponible: bool,

    }

    public fun crear_biblioteca(ctx: &mut TxContext) {
        let biblioteca = Biblioteca{
            id: object::new(ctx),
            nombre: utf8"(b"Biblioteca Sui Latinoamericana"),
        };
    }

    //public struct Usuario has drop{
    //    nombre: String,
    //    edad: u8,
    //    vivo: bool,
    //}
    //fun practica(usuario: Usuario) {
    //    if(usuario.edad > 18){
    //        print(&utf8(b"Aacceso Permitido"));
    //        print(&utf8(b"Aacceso Permitido"));
    //        print(&utf8(b"Aacceso Permitido"));
    //    } else if (usuario.edad == 18){
    //        print(&utf8(b"Felicidades"));
    //    } else {
    //        print(&utf8(b"Aacceso  NO Permitido"));
     //   }
    //}

    //#[test]
    //fun prueba() {
    //    let usuario = Usuario{
    //        nombre: utf8(b"Juan Sanchez"),
    //        edad:18,
     //       vivo: true,
    //    };

    //    practica(usuario);
    //}
}