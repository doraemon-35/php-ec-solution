{* Reviews page template *}

{* Canonical page address *}
{$canonical="/{$page->url}" scope=global}

<!-- Breadcrumb /-->
{$level = 1}
<nav class="mt-4" aria-label="breadcrumb">
    <ol itemscope itemtype="http://schema.org/BreadcrumbList" class="breadcrumb bg-light">
        <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item">
            <a itemprop="item" href="{if $lang_link}{$lang_link}{else}/{/if}"><span itemprop="name" title="{$lang->home}">{$lang->home}</span></a>
            <meta itemprop="position" content="{$level++}" />
        </li>
        <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem" class="breadcrumb-item active" aria-current="page">
            <a itemprop="item" href="{$lang_link}{$page->url}"><span itemprop="name">{$page->header|escape}</span></a>
            <meta itemprop="position" content="{$level++}" />
        </li>
    </ol>
</nav>
<!-- Breadcrumb #End /-->

<!-- Page title -->
<h1 data-page="{$page->id}" class="my-4">{$page->name|escape}</h1>
<div class="rating-wrap mb-2 ratings reviews">
    <ul class="rating-stars rater-starsOff" style="width:132px;">
        <li style="width:{$ratings*100/5|string_format:"%.0f"}%" class="stars-active rater-starsOn">
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
            <i class="fa fa-star"></i>
        </li>
        <li>
            <i class="far fa-star"></i>
            <i class="far fa-star"></i>
            <i class="far fa-star"></i>
            <i class="far fa-star"></i>
            <i class="far fa-star"></i>
        </li>
    </ul>
    {if $ratings > 0}
        <div class="label-rating">
            <span class="test-text">
                <span class="rater-rating h3">{$ratings|string_format:"%.1f"}</span>
            </span>
        </div>
    {/if}
</div>
<!-- rating-wrap.// -->
<!-- Page body -->
{$page->body}

{* Comments *}
{if $settings->comments_tree_reviews == "on"}
    {include file='comments_tree_reviews.tpl'}
{else}
    {include file='comments_reviews.tpl'}
{/if}