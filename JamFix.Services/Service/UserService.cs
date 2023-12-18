using JamFix.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace JamFix.Services.Service
{
    public class UserService
    {
        private readonly Context _context;

        public UserService(Context context)
        {
            _context = context ?? throw new ArgumentNullException(nameof(context));
        }

        public Korisnik AuthenticateUser(string email, string password)
        {
            // U ovom primjeru, koristit ćemo fikcionalni popis korisnika.
            var user = GetUserFromDatabaseByEmail(email);

            if (user != null && VerifyPassword(password, user.LozinkaHash))
            {
                // Ako je lozinka ispravna, vraćamo korisnika.
                return user;
            }

            // Ako korisnik nije pronađen ili lozinka nije ispravna, vraćamo null.
            return null;
        }
        // Ova metoda simulira dohvat korisnika iz baze podataka prema e-mail adresi.
        private Korisnik GetUserFromDatabaseByEmail(string email)
        {
            // Implementirajte stvarni dohvat korisnika iz baze podataka prema e-mail adresi.
            return _context.Korisnik.FirstOrDefault(k => k.Email == email);
        }

        // Ova metoda simulira provjeru lozinke prema pohranjenom hashu lozinke.
        private bool VerifyPassword(string enteredPassword, string storedPasswordHash)
        {
            // Koristite BCrypt.Net za usporedbu hashova
            using (var sha256 = SHA256.Create())
            {
                var enteredPasswordBytes = Encoding.UTF8.GetBytes(enteredPassword);
                var hashedPasswordBytes = sha256.ComputeHash(enteredPasswordBytes);

                // Usporedite dobiveni hash s pohranjenim hashom
                return hashedPasswordBytes.SequenceEqual(Convert.FromBase64String(storedPasswordHash));
            }
        }

    }
}
