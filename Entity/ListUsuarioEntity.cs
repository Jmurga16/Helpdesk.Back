namespace Entity
{
    public class ListUsuarioEntity
    {
        public int IdUsuario { get; set; }
        public string Correo { get; set; } = String.Empty;
        public string Nombres { get; set; } = String.Empty;
        public string Rol { get; set; } = String.Empty;
        public bool Activo { get; set; }
    }
}
