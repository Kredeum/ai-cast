<script lang="ts">
	import { WagmiProvider } from "@byteatatime/wagmi-svelte";
	import "../app.pcss";
	import ScaffoldEthApp from "$lib/components/ScaffoldEthApp.svelte";
	import { wagmiConfig } from "$lib/wagmi";
	import { Toaster } from "@leodog896/svelte-french-toast";
	import type { Snippet } from "svelte";

	let { children, data }: { children: Snippet; data: { url: string } } = $props();

	const baseUrl = $derived(data.url || "");

	const metadata = $derived({
		title: "Scaffold-ETH Alt App",
		description: "Built with 🏗 Scaffold-ETH Alt",
		thumbnail: `${baseUrl}/thumbnail.jpg`,
		favicon: "/favicon.png"
	});
</script>

<svelte:head>
	<title>{metadata.title}</title>
	<meta name="description" content={metadata.description} />
	<meta property="og:title" content={metadata.title} />
	<meta property="og:description" content={metadata.description} />
	<meta property="og:image:url" content={metadata.thumbnail} />
	<meta property="twitter:card" content="summary_large_image" />
	<meta property="twitter:image" content={metadata.thumbnail} />
	<meta property="twitter:title" content={metadata.title} />
	<meta property="twitter:description" content={metadata.description} />
	<link rel="icon" type="image/png" href={metadata.favicon} sizes="32x32" />
</svelte:head>

<Toaster />

<WagmiProvider config={wagmiConfig}>
	<ScaffoldEthApp>
		{@render children()}
	</ScaffoldEthApp>
</WagmiProvider>
