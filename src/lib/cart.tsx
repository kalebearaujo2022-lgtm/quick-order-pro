import { createContext, useContext, useEffect, useMemo, useState } from "react";

export type CartAddon = { id: string; name: string; price: number };

export type CartItem = {
  key: string;
  productId: string;
  name: string;
  imageUrl: string | null;
  basePrice: number;
  quantity: number;
  addons: CartAddon[];
  removed: string[];
  notes: string;
  restaurantId: string;
};

type Ctx = {
  items: CartItem[];
  count: number;
  subtotal: number;
  add: (item: Omit<CartItem, "key">) => void;
  remove: (key: string) => void;
  setQuantity: (key: string, q: number) => void;
  clear: () => void;
};

const CartCtx = createContext<Ctx>({
  items: [],
  count: 0,
  subtotal: 0,
  add: () => {},
  remove: () => {},
  setQuantity: () => {},
  clear: () => {},
});

export function itemUnitPrice(item: Pick<CartItem, "basePrice" | "addons">) {
  return item.basePrice + item.addons.reduce((s, a) => s + Number(a.price), 0);
}

export function CartProvider({ children }: { children: React.ReactNode }) {
  const [items, setItems] = useState<CartItem[]>([]);
  const [loaded, setLoaded] = useState(false);

  useEffect(() => {
    try {
      const raw = localStorage.getItem("av-cart");
      if (raw) setItems(JSON.parse(raw));
    } catch {
      /* ignore */
    }
    setLoaded(true);
  }, []);

  useEffect(() => {
    if (loaded) localStorage.setItem("av-cart", JSON.stringify(items));
  }, [items, loaded]);

  const value = useMemo<Ctx>(() => {
    const subtotal = items.reduce((s, i) => s + itemUnitPrice(i) * i.quantity, 0);
    return {
      items,
      count: items.reduce((s, i) => s + i.quantity, 0),
      subtotal,
      add: (item) => {
        const signature = `${item.productId}|${item.addons
          .map((a) => a.id)
          .sort()
          .join(",")}|${item.removed.sort().join(",")}|${item.notes}`;
        setItems((prev) => {
          const found = prev.find((p) => p.key === signature);
          if (found) {
            return prev.map((p) =>
              p.key === signature ? { ...p, quantity: p.quantity + item.quantity } : p,
            );
          }
          return [...prev, { ...item, key: signature }];
        });
      },
      remove: (key) => setItems((prev) => prev.filter((p) => p.key !== key)),
      setQuantity: (key, q) =>
        setItems((prev) =>
          q <= 0 ? prev.filter((p) => p.key !== key) : prev.map((p) => (p.key === key ? { ...p, quantity: q } : p)),
        ),
      clear: () => setItems([]),
    };
  }, [items]);

  return <CartCtx.Provider value={value}>{children}</CartCtx.Provider>;
}

export const useCart = () => useContext(CartCtx);
