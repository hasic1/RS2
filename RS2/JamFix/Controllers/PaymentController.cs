using JamFix.Model.Modeli;
using JamFix.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stripe;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace RealEstateAgency.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PaymentController : ControllerBase
    {
        public PaymentController(IUslugeService uslugeService)
        {
            _uslugeService = uslugeService;
        }

        private Token stripeToken;
        private TokenService Tokenservice;

        private string StripePublishableApiKey = "pk_test_51OYqyiFJavMmN9lElH6dxkRe7BKrKlwBzmhGEVkFCq3LS7x5MkgNxyNmLC48OjVArXLlGT8Ko6On76ysfWVTsUtT00bNVNGrpV";
        private string StripeSecretApiKey = "sk_test_51OYqyiFJavMmN9lEHYOinCIgUffaB493XjhUGTvXmXgHizTZMQyfiBDD2gwT3ooovIwGBU91gXRwAEytsmByPcbc00V5LeI9dl";
        private IUslugeService _uslugeService;

        public bool IsTransactionSuccess { get; set; }

        [HttpPost]
        [Route("ProccessPayment")]
        public async Task<IActionResult> ProccessPayment(CreditCard creditCard)
        {
            CancellationTokenSource tokenSource = new CancellationTokenSource();
            CancellationToken token = tokenSource.Token;
            await Task.Run(() =>
            {
                var Token = CreateToken(creditCard);
                if (Token != null)
                    IsTransactionSuccess = MakePayment(Token, creditCard.Amount, creditCard.Currency, creditCard.PropertyId, creditCard.Description);
            });
            if (IsTransactionSuccess)
            {
                return Ok();
            }
            else
            {
                return StatusCode(500);
            }
            return StatusCode(500);
        }

        private string CreateToken(CreditCard creditCard)
        {
            try
            {
                StripeConfiguration.SetApiKey(StripePublishableApiKey);
                var service = new ChargeService();

                var tokenOptions = new TokenCreateOptions
                {
                    Card = new TokenCardOptions
                    {
                        Number = creditCard.Number.ToString(),
                        ExpYear = creditCard.ExpYear.ToString(),
                        ExpMonth = creditCard.ExpMonth.ToString(),
                        Cvc = creditCard.Cvc,
                        Name = creditCard.Name,
                        AddressState = creditCard.AddressState,
                        AddressCountry = creditCard.AddressCountry,
                        AddressLine1 = creditCard.AddressLine1,
                        Currency = creditCard.Currency,
                        AddressLine2 = "SpringBoard",
                        AddressCity = "Gurgoan",
                        AddressZip = "284005",
                    }
                };

                Tokenservice = new TokenService();
                stripeToken = Tokenservice.Create(tokenOptions);
                return stripeToken.Id;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private bool MakePayment(string token, long? amount, string currency, int propertyId, string description)
        {
            try
            {
                StripeConfiguration.SetApiKey(StripeSecretApiKey);
                var options = new ChargeCreateOptions
                {
                    Amount = amount,
                    Currency = currency,
                    Description = description,
                    Source = stripeToken.Id,
                    StatementDescriptor = "Custom descriptor",
                    Capture = true,
                    ReceiptEmail = "tarikcolakhodzic@gmail.com",
                };

                //Make Payment
                var service = new ChargeService();
                Charge charge = service.Create(options);
                _uslugeService.SetPaid(propertyId, true, charge.Id);
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetCharges()
        {
            StripeConfiguration.SetApiKey(StripeSecretApiKey);
            var service = new ChargeService();
            ChargeListOptions options = new ChargeListOptions();
            //Maksimalan broj koji Api vraća
            options.Limit = 100;
            var response = await service.ListAsync(options);
            return Ok(response);
        }
    }
}