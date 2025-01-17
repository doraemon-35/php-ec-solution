{if $payment_method->id}
	{$meta_title = $payment_method->name scope=global}
{else}
	{$meta_title = $btr->payment_method_new scope=global}
{/if}

<h1 class="mb-3">
	{if !$payment_method->id}
		{$btr->payment_method_add|escape}
	{else}
		{$payment_method->name|escape}
	{/if}
</h1>

{if isset($message_success)}
	<div class="row">
		<div class="col-12">
			<div class="alert alert-success alert-dismissible fade show" role="alert">
				<div class="alert-message">
					{if $message_success == 'added'}
						{$btr->payment_method_added|escape}
					{elseif $message_success == 'updated'}
						{$btr->payment_method_updated|escape}
					{else}
						{$message_success|escape}
					{/if}
					{if $smarty.get.return}
						<a class="alert-link fw-normal btn-return text-decoration-none me-5" href="{$smarty.get.return}">
							<i class="align-middle mt-n1" data-feather="corner-up-left"></i>
							{$btr->global_back|escape}
						</a>
					{/if}
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</div>
		</div>
	</div>
{/if}

{if isset($message_error)}
	<div class="row">
		<div class="col-12">
			<div class="alert alert-danger alert-dismissible fade show" role="alert">
				<div class="alert-message">
					{if $message_error=='empty_name'}
						{$btr->global_enter_name|escape}
					{else}
						{$message_error|escape}
					{/if}
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
			</div>
		</div>
	</div>
{/if}

<form method="post" enctype="multipart/form-data" class="js-fast-button">
	<input type="hidden" name="session_id" value="{$smarty.session.id}">

	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-body">
					<div class="row d-flex">
						<div class="col-lg-10 col-md-9 col-sm-12">
							<div class="translate-container mb-3">
								<div class="form-label">{$btr->global_title|escape} <span class="translate-button" role="button" tabindex="0" data-bs-toggle="tooltip" data-bs-placement="top" title="{$btr->global_translation|escape}">{include file='svg_icon.tpl' svgId='translate'}</span></div>
								<input class="form-control mb-h translate-input" name="name" type="text" value="{if isset($payment_method->name)}{$payment_method->name|escape}{/if}">
								<input name="id" type="hidden" value="{$payment_method->id|escape}">
							</div>
						</div>
						<div class="col-lg-2 col-md-3 col-sm-12">
							<div class="d-flex justify-content-center align-content-center flex-wrap flex-md-column h-100">
								<div class="form-check form-switch form-check-reverse ms-2 mb-2 mb-sm-1">
									<input class="form-check-input ms-2" type="checkbox" id="enabled" name="enabled" value="1" type="checkbox" {if isset($payment_method->enabled) && $payment_method->enabled}checked=""{/if}>
									<label class="form-check-label ms-2" for="enabled">{$btr->global_enable|escape}</label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->global_method_settings|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<div class="row">
							<div class="col-12">
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group clearfix">
											<div class="form-label">{$btr->global_method_type|escape}</div>
											<select name="module" class="selectpicker">
												<option value='null'>{$btr->global_method_manual|escape}</option>
												{foreach $payment_modules as $payment_module}
													<option value="{$payment_module@key|escape}" {if isset($payment_method->module) && $payment_method->module == $payment_module@key}selected{/if}>{$payment_module->name|escape}</option>
												{/foreach}
											</select>
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group clearfix">
											<div class="form-label">{$btr->global_currency|escape}</div>
											<select name="currency_id" class="selectpicker">
												{foreach $currencies as $currency}
													<option value="{$currency->id}" {if isset($payment_method->currency_id) && $currency->id == $payment_method->currency_id}selected{/if}>{$currency->name|escape}</option>
												{/foreach}
											</select>
										</div>
									</div>
									<div class="col-12 mt-3">
										{foreach $payment_modules as $payment_module}
											<div class="row js-module-settings" {if $payment_method->id}{if $payment_module@key != $payment_method->module}style="display:none;" {/if}{else}style="display:none;" {/if} module="{$payment_module@key}">
												<h4>{$payment_module->name|escape}</h4>
												{foreach $payment_module->settings as $setting}
													{if !empty($setting->options) && $setting->options|@count > 1}
														<div class="col-lg-6">
															<div class="mb-3">
																<div class="form-label">{$setting->name|escape}</div>
																<select name="payment_settings[{$setting->variable}]" class="selectpicker">
																	{foreach $setting->options as $option}
																		<option value="{$option->value}" {if isset($payment_settings[$setting->variable]) && $option->value == $payment_settings[$setting->variable]}selected{/if}>{$option->name|escape}</option>
																	{/foreach}
																</select>
															</div>
														</div>
													{elseif !empty($setting->options) && $setting->options|@count == 1}
														{$option = $setting->options|@first}
														<div class="col-lg-6 d-flex align-items-center">
															<div class="form-check form-switch mb-3 mt-lg-3 mt-0">
																<input class="form-check-input me-2" type="checkbox" id="payment-settings-{$option->value|escape}" name="payment_settings[{$setting->variable}]" value="{$option->value|escape}" {if $option->value==$payment_settings[$setting->variable]}checked{/if}>
																<label class="form-check-label" for="payment-settings-{$option->value|escape}">{$setting->name|escape}</label>
															</div>
														</div>
													{else}
														<div class="col-lg-6">
															<div class="mb-3">
																<div class="form-label" for="{$setting->variable}">{$setting->name|escape}</div>
																<input name="payment_settings[{$setting->variable}]" class="form-control" type="text" value="{if isset($payment_settings[$setting->variable])}{$payment_settings[$setting->variable]|escape}{/if}" id="{$setting->variable}">
															</div>
														</div>
													{/if}
												{/foreach}
											</div>
										{/foreach}
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row gx-2">
		<div class="col-lg-4 col-md-12">
			<div class="card mh-250px">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->global_icon|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<ul class="checkout-images-list mb-1">
							<li class="checkout-image-item border-image-item-two {if isset($payment_method->icon) && $payment_method->icon}border{/if}">
								{if isset($payment_method->icon) && $payment_method->icon}
									<input type="hidden" class="js-accept-delete-two" name="delete_icon" value="">
									<div class="js-parent-image-two">
										<div class="checkout-image image-wrapper js-image-wrapper-two text-xs-center">
											<a href="javascript:;" class="js-delete-item-two remove-image"></a>
											<img src="../{$config->payment_images_dir}{$payment_method->icon}" alt="">
										</div>
									</div>
								{else}
									<div class="js-parent-image-two"></div>
								{/if}
								<div class="js-upload-image-two dropzone-block-image {if isset($payment_method->icon) && $payment_method->icon}d-none{/if}">
									<i class="align-middle" data-feather="plus"></i>
									<input class="dropzone-image-two" name="icon" type="file">
								</div>
								<div class="checkout-image image-wrapper js-image-wrapper-two js-new-image-two text-xs-center">
									<a href="javascript:;" class="js-delete-item-two remove-image"></a>
									<img src="" alt="">
								</div>
							</li>
						</ul>
						<div class="form-label">{$btr->icon_code|escape}</div>
						<input class="form-control" name="code" type="text" value="{if isset($payment_method->code)}{$payment_method->code|escape}{/if}">
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-8 col-md-12">
			<div class="card mh-250px">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->payment_method_shipping|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<div class="row">
							{foreach $deliveries as $delivery}
								<div class="col-lg-3 col-md-4 col-sm-12 my-2">
									<div class="d-flex align-items-center">
										<div class="form-check">
											<input class="form-check-input me-2" id="payment-deliveries-{$delivery->id}" value="{$delivery->id}" type="checkbox" name="payment_deliveries[]" {if in_array($delivery->id, $payment_deliveries)}checked{/if}>
										</div>
										<label class="form-check-label" for="payment-deliveries-{$delivery->id}">{$delivery->name|escape}</label>
									</div>
								</div>
							{/foreach}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12">
			<div class="card">
				<div class="card-header">
					<div class="card-actions float-end">
						<div class="d-block d-lg-none position-relative collapse-icon">
							<a href="javascript:;" class="collapse-chevron">
								<i class="align-middle" data-feather="chevron-up"></i>
							</a>
						</div>
					</div>
					<h5 class="card-title mb-0">{$btr->global_description|escape}</h5>
				</div>
				<div class="collapse-card">
					<div class="card-body">
						<textarea name="description" id="js-editor" class="editor js-editor-class">{if isset($payment_method->description)}{$payment_method->description|escape}{/if}</textarea>
						<div class="row">
							<div class="col-12">
								<div class="d-grid d-sm-block mt-3">
									<button type="submit" class="btn btn-primary float-end">
										<i class="align-middle" data-feather="check"></i>
										{$btr->global_apply|escape}
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>

{* TinyMCE *}
{include file='tinymce_init.tpl'}

{literal}
	<script>
		$(function() {
			$('div.js-module-settings').filter(':hidden').find("input, select, textarea").attr("disabled", true);
			$('select[name=module]').on('change', function() {
				$('div.js-module-settings').hide().find("input, select, textarea").attr("disabled", true);
				$('div.js-module-settings[module=' + $(this).val() + ']').show().find("input, select, textarea").attr("disabled", false);
				$('div.js-module-settings[module=' + $(this).val() + ']').find('select').selectpicker('refresh');
			});
		});
	</script>
{/literal}