﻿using System.Collections.Generic;

namespace Application.ViewModels.Catalog
{
    public class ProductDetailVm
    {
        public int Id { get; set; }
        public int Stock { get; set; }
        public decimal Price { get; set; }        
        public List<ComponentDetailVm> ComponentDetails { get; set; } = new List<ComponentDetailVm>();
    }
}
