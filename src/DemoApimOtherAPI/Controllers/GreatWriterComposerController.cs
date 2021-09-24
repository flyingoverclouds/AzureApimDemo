using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DemoApimOtherAPI.Controllers
{
    [ApiController]
    [Route("writer")]
    public class GreatWriterComposerController : ControllerBase
    {
        private static readonly string[] Writers= new[]
        {
            "Victor Hugo", "Franck Herbert", "Isaac Asimov", "George Orwell", "Robert Merle"
        };

        private readonly ILogger<GreatWriterComposerController> _logger;

        public GreatWriterComposerController(ILogger<GreatWriterComposerController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public String Get()
        {
            var rng = new Random((int)DateTime.Now.Ticks);
            return Writers[rng.Next(Writers.Length)];
        }
    }
}
