namespace Entity
{
    public class MenuEntity
    {
        public int IdMenu { get; set; }
        public string Name { get; set; } = String.Empty;
        public string Route { get; set; } = String.Empty;
        public string Icon { get; set; } = String.Empty;
        public int IdParent { get; set; }
        public int Level { get; set; }
        public bool Status { get; set; }

    }
}
