"use strict";


import { bangs } from "./bangs.js";

function getBangredirectUrl(query) {
  const LS_DEFAULT_BANG = "g";
  const defaultBang = bangs.find((b) => b.t === LS_DEFAULT_BANG);

  if (!query) return null;

  try {
    query = decodeURIComponent(query);
  } catch (e) {
    console.warn("Failed to decode query", query, e);
  }

  const match = query.match(/!(\S+)/i);
  const bangCandidate = match?.[1]?.toLowerCase();
  const selectedBang = bangs.find((b) => b.t === bangCandidate) ?? defaultBang;

  const cleanQuery = query.replace(/!\S+\s*/i, "").trim();

  const searchUrl = selectedBang?.u.replace(
    "{{{s}}}",
    encodeURIComponent(cleanQuery).replace(/%2F/g, "/")
  );

  return searchUrl || "https://search.thomasdye.net";
}



browser.webNavigation.onBeforeNavigate.addListener((details) => {
        const qurl = "https://search.thomasdye.net?q="
      try {
          const url = new URL(details.url);
          const key = url.hostname.endsWith("yahoo.com") ? "p" : "q";
          const query = encodeURIComponent(url.searchParams.get(key));
            
          browser.tabs.update(details.tabId, { url: getBangredirectUrl(query) });
        
      } catch (e) {
        console.error("%O", e);
      }
}, {
  url:
  [
    {urlPrefix: "https://www.google.", pathEquals: "/search", queryPrefix: "client=safari&", queryContains: "&q=", querySuffix: "&ie=UTF-8&oe=UTF-8"},
    {urlPrefix: "https://www.google.", pathEquals: "/search", queryPrefix: "q=", queryContains: "&ie=UTF-8&oe=UTF-8&", querySuffix: "&client=safari"},
    {hostEquals: "search.yahoo.com", pathEquals: "/search", queryPrefix: "ei=utf-8&fr=aaplw&p="},
    {hostEquals: "search.yahoo.com", pathEquals: "/search", queryPrefix: "p=", querySuffix: "&fr=iphone&.tsrc=apple"},
    {hostSuffix: ".search.yahoo.com", pathEquals: "/search", queryPrefix: "ei=utf-8&fr=aaplw&p="},
    {hostSuffix: ".search.yahoo.com", pathEquals: "/search", queryPrefix: "p=", querySuffix: "&fr=iphone&.tsrc=apple"},
    {urlPrefix: "https://www.bing.com/search?q=", querySuffix: "&form=APMCS1&PC=APMC"},
    {urlPrefix: "https://www.bing.com/search?q=", querySuffix: "&form=APIPH1&PC=APPL"},
    {urlPrefix: "https://duckduckgo.com/?q=", querySuffix: "&t=osx"},
    {urlPrefix: "https://duckduckgo.com/?q=", querySuffix: "&t=iphone"},
    {urlPrefix: "https://www.ecosia.org/search?q=", querySuffix: "&tts=st_asaf_macos"},
    {urlPrefix: "https://www.ecosia.org/search?q=", querySuffix: "&tts=st_asaf_iphone"}
  ],
  types: ["main_frame"]
});
