using AutoMapper;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;
using System.Text;

namespace JamFixTestAPI2.Auth
{
    public class UserService : IUser
    {
        private readonly Context _context;
        IMapper _mapper;
        public UserService(Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public async Task<Korisnici> Login(string username, string password)
        {
            var entity = await _context.Korisnici.FirstOrDefaultAsync(x => x.KorisnickoIme == username);
            if (entity == null)
            {
                return null;
            }
            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (hash != entity.LozinkaHash)
            {
                return null;
            }
            return _mapper.Map<Korisnici>(entity);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
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
            return _context.Korisnici.FirstOrDefault(k => k.Email == email);
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
