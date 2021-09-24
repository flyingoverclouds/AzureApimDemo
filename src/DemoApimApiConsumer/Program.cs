using System;
using System.Net.Http.Headers;
using System.Text;
using System.Net.Http;
using System.Web;

namespace DemoApimApiConsumer
{
    static class Program
    {
        const string apimBaseUrl = "https://ncdemoapim.azure-api.net";
        const string apimKey = "56fbb4f917314b35933c0bc7aae57fa4";

        static void Main()
        {
            do
            {
                MakeRequest();
                Console.WriteLine("Hit ENTER to continue...");
                Console.ReadLine();
            } while (true);
        }

        static async void MakeRequest()
        {
            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.CacheControl = CacheControlHeaderValue.Parse("no-cache");
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", apimKey);
            var uri = $"{apimBaseUrl}/meteo?{queryString}";

            //var response = await client.GetAsync(uri);
            var meteo=await client.GetStringAsync(uri);

            Console.WriteLine("METEO:");
            Console.WriteLine(meteo);


        }
    }
}