export function money(value: number, lang: string = "pt") {
  return new Intl.NumberFormat(lang === "en" ? "en-US" : "pt-BR", {
    style: "currency",
    currency: lang === "en" ? "USD" : "BRL",
  }).format(value || 0);
}

export const WHATSAPP_NUMBER = "5568992390173";

export function whatsappLink(
  message = "Olá! Vim pelo Atendente Virtual e gostaria de falar com o estabelecimento.",
) {
  return `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
}
