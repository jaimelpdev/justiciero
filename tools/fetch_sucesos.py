#!/usr/bin/env python3
"""Genera web/feeds/<ciudad>.json con las noticias de sucesos de los últimos días.

La app web no puede leer Google Noticias directamente desde el navegador (CORS),
así que el workflow de despliegue ejecuta este script cada hora y publica los
resultados junto a la web. La app nativa de iOS consulta Google Noticias directamente.

Uso:  python3 tools/fetch_sucesos.py web/feeds
"""
import json
import sys
import unicodedata
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from email.utils import parsedate_to_datetime
from pathlib import Path

CITIES = [
    "Madrid", "Barcelona", "Valencia", "Sevilla", "Zaragoza", "Málaga", "Murcia", "Palma",
    "Las Palmas de Gran Canaria", "Bilbao", "Alicante", "Córdoba", "Valladolid", "Vigo", "Gijón",
    "L'Hospitalet de Llobregat", "Vitoria", "A Coruña", "Granada", "Elche", "Oviedo",
    "Santa Cruz de Tenerife", "Badalona", "Cartagena", "Terrassa", "Jerez de la Frontera",
    "Sabadell", "Móstoles", "Alcalá de Henares", "Pamplona", "Fuenlabrada", "Almería",
    "Leganés", "San Sebastián", "Getafe", "Burgos", "Santander", "Castellón de la Plana",
    "Albacete", "Alcorcón", "Logroño", "Badajoz", "Salamanca", "Huelva", "Marbella",
    "Lleida", "Tarragona", "León", "Cádiz", "Jaén", "Ourense", "Girona", "Lugo", "Cáceres",
    "Toledo", "Pontevedra", "Palencia", "Ceuta", "Melilla", "Zamora", "Ávila", "Cuenca",
    "Segovia", "Huesca", "Soria", "Teruel", "Guadalajara", "Ciudad Real",
]

TERMS = "(sucesos OR detenido OR detenida OR robo OR atraco OR agresión OR apuñalado OR reyerta OR policía)"
MAX_ITEMS = 30


def slug(city: str) -> str:
    text = unicodedata.normalize("NFKD", city).encode("ascii", "ignore").decode().lower()
    return "".join(c if c.isalnum() else "-" for c in text).strip("-")


def fetch(city: str) -> list:
    query = f'"{city}" {TERMS} when:3d'
    url = "https://news.google.com/rss/search?" + urllib.parse.urlencode(
        {"q": query, "hl": "es", "gl": "ES", "ceid": "ES:es"})
    req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0 (Justiciero)"})
    with urllib.request.urlopen(req, timeout=20) as resp:
        root = ET.fromstring(resp.read())
    items = []
    for item in root.iter("item"):
        title = (item.findtext("title") or "").strip()
        source = (item.findtext("source") or "").strip()
        if source and title.endswith(" - " + source):
            title = title[: -len(" - " + source)]
        try:
            date = parsedate_to_datetime(item.findtext("pubDate") or "").astimezone(timezone.utc)
        except (TypeError, ValueError):
            continue
        items.append({"title": title, "source": source, "link": item.findtext("link") or "",
                      "date": date.isoformat()})
    items.sort(key=lambda x: x["date"], reverse=True)
    return items[:MAX_ITEMS]


def main():
    out = Path(sys.argv[1] if len(sys.argv) > 1 else "web/feeds")
    out.mkdir(parents=True, exist_ok=True)
    now = datetime.now(timezone.utc).isoformat()
    index = []
    for city in CITIES:
        try:
            items = fetch(city)
        except Exception as error:  # una ciudad que falla no debe impedir el resto
            print(f"{city}: error {error}", file=sys.stderr)
            continue
        (out / f"{slug(city)}.json").write_text(
            json.dumps({"city": city, "updated": now, "items": items}, ensure_ascii=False))
        index.append({"city": city, "slug": slug(city)})
        print(f"{city}: {len(items)} noticias")
    (out / "index.json").write_text(json.dumps({"updated": now, "cities": index}, ensure_ascii=False))


if __name__ == "__main__":
    main()
