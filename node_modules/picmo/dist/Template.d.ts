export declare type TemplateData = Record<string, any>;
declare type RenderMode = 'sync' | 'async';
declare type TemplateOptions = {
    mode: RenderMode;
};
export declare class Template<E extends HTMLElement = HTMLElement> {
    #private;
    constructor(templateFn: (TemplateData: any) => string, options?: Partial<TemplateOptions>);
    renderSync(data?: TemplateData): E;
    renderAsync(data?: TemplateData): Promise<E>;
    render(data: TemplateData): E | Promise<E>;
}
export {};
