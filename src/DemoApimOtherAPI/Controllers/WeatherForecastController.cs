using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DemoApimOtherAPI.Controllers
{
    [ApiController]
    [Route("meteov2")]
    public class WeatherForecastControllerV2 : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Ca caille un max", "Glagla", "Pas chaud", "Ca va", "Ca se rechauffe", "Chaud", "Un peu trop chaud", "Tres Chaud", "Chaud brulant", "Oups ... Au feu ..."
        };

        private readonly ILogger<WeatherForecastControllerV2> _logger;

        public WeatherForecastControllerV2(ILogger<WeatherForecastControllerV2> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public IEnumerable<WeatherForecast> Get()
        {
            var rng = new Random();
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateTime.Now.AddDays(index),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
