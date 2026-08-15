import { createContext, useCallback, useContext, useEffect, useMemo, useState } from "react";

export type Lang = "pt" | "en";

const dict: Record<string, { pt: string; en: string }> = {
  "nav.home": { pt: "Início", en: "Home" },
  "nav.menu": { pt: "Cardápio", en: "Menu" },
  "nav.cart": { pt: "Carrinho", en: "Cart" },
  "nav.orders": { pt: "Pedidos", en: "Orders" },
  "nav.profile": { pt: "Perfil", en: "Profile" },
  "nav.plans": { pt: "Planos", en: "Plans" },
  "nav.reviews": { pt: "Avaliações", en: "Reviews" },
  "nav.rewards": { pt: "Roleta", en: "Rewards" },
  "nav.dashboard": { pt: "Painel", en: "Dashboard" },
  "nav.favorites": { pt: "Favoritos", en: "Favorites" },
  "cta.viewMenu": { pt: "Ver Cardápio", en: "View Menu" },
  "cta.order": { pt: "Fazer Pedido", en: "Order Now" },
  "cta.login": { pt: "Entrar", en: "Sign in" },
  "cta.signup": { pt: "Cadastrar", en: "Sign up" },
  "cta.logout": { pt: "Sair", en: "Sign out" },
  "cta.add": { pt: "Adicionar", en: "Add" },
  "cta.addToCart": { pt: "Adicionar ao Carrinho", en: "Add to cart" },
  "cta.checkout": { pt: "Finalizar Pedido", en: "Checkout" },
  "cta.startNow": { pt: "Começar agora", en: "Start now" },
  "cta.orderAgain": { pt: "Pedir novamente", en: "Order again" },
  "cta.save": { pt: "Salvar", en: "Save" },
  "hero.title": { pt: "Seu pedido do seu jeito.", en: "Your order, your way." },
  "hero.subtitle": {
    pt: "Escolha seus pratos favoritos, personalize seu pedido e acompanhe tudo em um só lugar.",
    en: "Pick your favorite dishes, customize your order and track everything in one place.",
  },
  "hero.tagline": {
    pt: "Escolha. Personalize. Peça. Acompanhe.",
    en: "Choose. Customize. Order. Track.",
  },
  "home.bestSellers": { pt: "🔥 Mais vendidos", en: "🔥 Best sellers" },
  "home.promos": { pt: "Promoções", en: "Promotions" },
  "home.categories": { pt: "Categorias", en: "Categories" },
  "home.combos": { pt: "Combos", en: "Combos" },
  "home.benefits": { pt: "Benefícios", en: "Benefits" },
  "home.reviews": { pt: "⭐ Mural de Avaliações", en: "⭐ Reviews wall" },
  "home.lastOrders": { pt: "Últimos pedidos", en: "Latest orders" },
  "home.rewards": { pt: "Programa de recompensas", en: "Rewards program" },
  "menu.search": { pt: "Buscar no cardápio...", en: "Search the menu..." },
  "menu.all": { pt: "Todos", en: "All" },
  "menu.empty": { pt: "Nenhum produto encontrado.", en: "No products found." },
  "product.ingredients": { pt: "Ingredientes", en: "Ingredients" },
  "product.remove": { pt: "Remover ingredientes", en: "Remove ingredients" },
  "product.notes": { pt: "Observações especiais", en: "Special notes" },
  "product.quantity": { pt: "Quantidade", en: "Quantity" },
  "cart.title": { pt: "Seu carrinho", en: "Your cart" },
  "cart.empty": { pt: "Seu carrinho está vazio.", en: "Your cart is empty." },
  "cart.subtotal": { pt: "Subtotal", en: "Subtotal" },
  "cart.discount": { pt: "Desconto", en: "Discount" },
  "cart.deliveryFee": { pt: "Taxa de entrega", en: "Delivery fee" },
  "cart.total": { pt: "Total", en: "Total" },
  "cart.coupon": { pt: "Cupom", en: "Coupon" },
  "cart.applyCoupon": { pt: "Aplicar", en: "Apply" },
  "checkout.title": { pt: "Finalizar pedido", en: "Checkout" },
  "checkout.howReceive": {
    pt: "Como você deseja receber seu pedido?",
    en: "How would you like to receive your order?",
  },
  "checkout.pickup": { pt: "Retirar no balcão", en: "Pick up at the counter" },
  "checkout.delivery": { pt: "Entrega", en: "Delivery" },
  "checkout.payment": { pt: "Pagamento", en: "Payment" },
  "checkout.change": { pt: "Precisa de troco? Para quanto?", en: "Need change? For how much?" },
  "checkout.confirm": { pt: "Confirmar pedido", en: "Confirm order" },
  "track.title": { pt: "Acompanhe seu pedido", en: "Track your order" },
  "orders.title": { pt: "Meus últimos pedidos", en: "My latest orders" },
  "profile.title": { pt: "Meu Perfil", en: "My Profile" },
  "profile.points": { pt: "Pontos", en: "Points" },
  "profile.coupons": { pt: "Cupons", en: "Coupons" },
  "profile.invoices": { pt: "Minhas Notas Fiscais", en: "My Invoices" },
  "a11y.title": { pt: "Acessibilidade", en: "Accessibility" },
  "a11y.increase": { pt: "Aumentar fonte", en: "Increase font" },
  "a11y.decrease": { pt: "Diminuir fonte", en: "Decrease font" },
  "a11y.contrast": { pt: "Alto contraste", en: "High contrast" },
  "a11y.motion": { pt: "Reduzir animações", en: "Reduce motion" },
  "a11y.links": { pt: "Destacar links e botões", en: "Highlight links & buttons" },
  "a11y.reset": { pt: "Restaurar padrão", en: "Reset" },
  "status.received": { pt: "Pedido recebido", en: "Order received" },
  "status.confirmed": { pt: "Pedido confirmado", en: "Order confirmed" },
  "status.preparing": { pt: "Preparando", en: "Preparing" },
  "status.ready": { pt: "Pronto", en: "Ready" },
  "status.ready_pickup": { pt: "Pronto para retirada", en: "Ready for pickup" },
  "status.on_the_way": { pt: "Saiu para entrega", en: "Out for delivery" },
  "status.delivered": { pt: "Entregue", en: "Delivered" },
  "status.picked_up": { pt: "Retirado", en: "Picked up" },
  "status.cancelled": { pt: "Cancelado", en: "Cancelled" },
};

type I18nCtx = { lang: Lang; setLang: (l: Lang) => void; t: (key: string) => string };
const Ctx = createContext<I18nCtx>({ lang: "pt", setLang: () => {}, t: (k) => k });

export function I18nProvider({ children }: { children: React.ReactNode }) {
  const [lang, setLangState] = useState<Lang>("pt");

  useEffect(() => {
    const saved = localStorage.getItem("av-lang") as Lang | null;
    if (saved === "pt" || saved === "en") setLangState(saved);
  }, []);

  const setLang = useCallback((l: Lang) => {
    setLangState(l);
    localStorage.setItem("av-lang", l);
  }, []);

  const t = useCallback((key: string) => dict[key]?.[lang] ?? key, [lang]);

  const value = useMemo(() => ({ lang, setLang, t }), [lang, setLang, t]);
  return <Ctx.Provider value={value}>{children}</Ctx.Provider>;
}

export const useI18n = () => useContext(Ctx);
