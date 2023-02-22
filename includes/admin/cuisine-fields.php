<?php

function hw_erp_cusine_add_form_fields(){
    ?>
        <div class="form-field">
                <label><?php _e('More Info URL', 'hard-work-erp'); ?></label>
                <input type text="text" name="hw_erp_more_info_url" />
                <p><?php _e('A URL a user can click to learn more information about this cusine', 'hard-work-erp'); ?></p>
        </div>
    <?php
}