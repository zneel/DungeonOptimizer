#!/usr/bin/env python3
"""
Playwright-based page fetcher for Icy Veins scraping.
Handles JS-rendered content and bot protection.

Usage:
    pip install playwright
    playwright install chromium
"""

import asyncio
import sys


async def _fetch_page(url, wait_selector="table", timeout=15000):
    """Fetch a single page using Playwright."""
    from playwright.async_api import async_playwright

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page(
            user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                       "AppleWebKit/537.36 (KHTML, like Gecko) "
                       "Chrome/120.0.0.0 Safari/537.36"
        )
        await page.goto(url, wait_until="domcontentloaded", timeout=60000)
        try:
            await page.wait_for_selector(wait_selector, timeout=timeout)
        except Exception:
            print(f"  Warning: selector '{wait_selector}' not found, using page as-is",
                  file=sys.stderr)
        # Give extra time for remaining JS to execute
        await asyncio.sleep(2)
        html = await page.content()
        await browser.close()
        return html


async def _fetch_pages_batch(urls, wait_selector="table", delay=2.0, timeout=15000):
    """Fetch multiple pages reusing one browser instance.

    Args:
        urls: dict of {key: url_string}
        wait_selector: CSS selector to wait for before extracting HTML
        delay: seconds between requests
        timeout: ms to wait for selector

    Returns:
        dict of {key: html_string}
    """
    from playwright.async_api import async_playwright

    results = {}
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page(
            user_agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
                       "AppleWebKit/537.36 (KHTML, like Gecko) "
                       "Chrome/120.0.0.0 Safari/537.36"
        )
        for key, url in urls.items():
            print(f"  Fetching {url}...", file=sys.stderr)
            try:
                await page.goto(url, wait_until="networkidle")
                try:
                    await page.wait_for_selector(wait_selector, timeout=timeout)
                except Exception:
                    print(f"  Warning: selector not found for {key}", file=sys.stderr)
                results[key] = await page.content()
            except Exception as e:
                print(f"  ERROR fetching {key}: {e}", file=sys.stderr)
            await asyncio.sleep(delay)
        await browser.close()
    return results


def fetch_page_sync(url, wait_selector="table", timeout=15000):
    """Synchronous wrapper for fetching a single page."""
    return asyncio.run(_fetch_page(url, wait_selector, timeout))


def fetch_pages_batch_sync(urls, wait_selector="table", delay=2.0, timeout=15000):
    """Synchronous wrapper for batch fetching."""
    return asyncio.run(_fetch_pages_batch(urls, wait_selector, delay, timeout))
