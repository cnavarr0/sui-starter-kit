module starter::practica_sui {
    use std::debug::print;
    //use std::string::utf8;
    //const CONSTANTE: u64 =1;

    fun practica() {
       // let mut variable = 1;
       //let mut variable: u8 = 256; 
        let mut variable = 256u16;
        variable = 2;
        //print(&utf8(b"Hello, World!"));
        print(&variable)
    }

    #[test]
    fun prueba() {
        practica();
    }
}