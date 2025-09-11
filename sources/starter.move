module starter::universidad{
    use std::string::{String};
    use sui::vec_map::{VecMap, Self};

    #[error]
    const MATRICULA_YA_EXISTE: vector<u8> = b"El alumno con esa matricula ya existe.";

   #[error]
    const MATRICULA_NO_EXISTE: vector<u8> = b"El alumno con esa matricula no existe.";

    #[error]
    const CLAVEMATERIA_YA_EXISTE: vector<u8> = b"Esa clave de la materia ya existe.";

   #[error]
    const CLAVEMATERIA_NO_EXISTE: vector<u8> = b"Esa clave de la materia no existe.";
    

    public struct Universidad has key{
        id: UID,
        nombreU: String,
        estudiantes: VecMap<u64, Estudiante>,
        materias: VecMap<u64, Materia>,
    }

    public struct Estudiante has store, drop{
        matricula: u64,
        nombreA: String,
        carrera: String,
        semestre: u8,
       // estado: Estado,
        estado: bool,  //Activo = True y Baja =False
        materiasAlu: vector<u64>,
    }

    /*public enum Estado{
        Activo,
        BajaTemporal,
        Baja,
    };*/

   public struct Materia has store, drop{
        clave: u64,
        nombreM: String,
        creditos: u8,
        profesor: String,
    }

    public fun crear_universidad(nombreU: String, ctx: &mut TxContext) {
        let universidad = Universidad{
            id: object::new(ctx),
            nombreU,
            estudiantes: vec_map::empty(),
            materias: vec_map::empty(),
        };

        transfer::transfer(universidad, tx_context::sender(ctx));

    }

    public fun agregar_estudiante(universidad: &mut Universidad, matricula: u64, nombreA:String, carrera: String, semestre: u8)
    {
       assert!(!universidad.estudiantes.contains(&matricula), MATRICULA_YA_EXISTE);

        let estudiante = Estudiante{
                matricula,
                nombreA,
                carrera,
                semestre,
                estado: true,
                materiasAlu: vector[]
        };

        universidad.estudiantes.insert(matricula, estudiante);
    }

    public fun agregar_materia(universidad: &mut Universidad, clave: u64, nombreM:String, creditos: u8, profesor: String)
    {
       assert!(!universidad.materias.contains(&clave), CLAVEMATERIA_YA_EXISTE);

        let materia = Materia{
                clave,
                nombreM,
                creditos,
                profesor,
        };

        universidad.materias.insert(clave, materia);
    }

      public fun agregar_materiaAlu(universidad: &mut Universidad, matricula: u64, clave: u64)
    {
       assert!(universidad.estudiantes.contains(&matricula), MATRICULA_NO_EXISTE);
       assert!(universidad.materias.contains(&clave), CLAVEMATERIA_NO_EXISTE);

        let estudianteRef  = universidad.estudiantes.get_mut(&matricula);
        estudianteRef.materiasAlu.push_back(clave);
              
    }

    public fun actualizar_estado(universidad: &mut Universidad, matricula: u64)
    {
       assert!(universidad.estudiantes.contains(&matricula), MATRICULA_NO_EXISTE);

        let estudiante = universidad.estudiantes.get_mut(&matricula);
        estudiante.estado = !estudiante.estado;       

    }


    public fun borrar_estudiante(universidad: &mut Universidad, matricula: u64)
    {
       assert!(universidad.estudiantes.contains(&matricula), MATRICULA_NO_EXISTE);

        universidad.estudiantes.remove(&matricula);

    }

    public fun borrar_materia(universidad: &mut Universidad, clave: u64)
    {
       assert!(universidad.materias.contains(&clave), CLAVEMATERIA_NO_EXISTE);

        universidad.materias.remove(&clave);

    }

}

//universidad.estudiantes.materiasAlu.push_back(materia);

/*
    #[error]
    const ID_YA_EXISTE: vector<u8> = b"El ID que se intento insertar ya existe.";

    #[error]
    const ID_NO_EXISTE: vector<u8> = b"El ID que se intento insertar ya existe.";

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

    public fun crear_biblioteca(nombre: String, ctx: &mut TxContext) {
        let biblioteca = Biblioteca{
            id: object::new(ctx),
            //nombre: utf8(b"Biblioteca Sui Latinoamericana"),
            nombre,
            libros: vec_map::empty(),
        };

        transfer::transfer(biblioteca, tx_context::sender(ctx));

    }

    public fun agregar_libro(biblioteca: &mut Biblioteca, id: u64, titulo:String, autor: String, publicacion: u16)
    {
       assert!(!biblioteca.libros.contains(&id), ID_YA_EXISTE);

        let libro = Libro{
                titulo,
                autor,
                publicacion,
                disponible: true,
        };

        biblioteca.libros.insert(id, libro);
    }

    public fun borrar_libro(biblioteca: &mut Biblioteca, id: u64)
    {
       assert!(!biblioteca.libros.contains(&id), ID_NO_EXISTE);

        biblioteca.libros.remove(&id);

    }

    public fun actualizar_disponibilidad(biblioteca: &mut Biblioteca, id: u64)
    {
       assert!(!biblioteca.libros.contains(&id), ID_NO_EXISTE);

        let libro = biblioteca.libros.get_mut(&id);
        libro.disponible = !libro.disponible;       

    }
*/
    


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