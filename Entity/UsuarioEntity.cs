namespace Entity
{
    public class UsuarioEntity
    {
        public int IdUsuario { get; set; }
        public int IdPersona { get; set; }
        public string Correo { get; set; } = String.Empty;
        public string PasswordHash { get; set; } = String.Empty;
        public bool Activo { get; set; }
    }
}
